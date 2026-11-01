/* dag.yml
dag: the_timetable
schedule: nightly
start_date: 2026-10-02
end_date: 2026-10-31
catchup: true

tasks:
  trip_updates_history:
    materialized: incremental
    incremental_strategy: append
    depends_on: [trip_updates]

  trips_history:
    materialized: incremental
    incremental_strategy: append
    depends_on: [trips]

  trip_actuals:
    materialized: table
    depends_on: [trip_updates_history, trips_history]
    tests:
      - unique: [trip_id, service_date]
      - not_null: [trip_id, service_date, unscheduled]
*/

-- each file is 1 SELECT, built into a table of the file's name; dag.yml says what it runs after

-- task: trip_updates_history
SELECT
    update_id,
    trip_id,
    CASE
        WHEN length(start_date) = 8
        THEN substr(start_date,1,4) || '-' || substr(start_date,5,2) || '-' || substr(start_date,7,2)
        ELSE NULL
    END AS service_date,
    NULLIF(NULLIF(TRIM(route_id), ''), '\N') AS route_id,
    CASE
        WHEN vehicle_id IS NULL OR TRIM(vehicle_id) = '' THEN NULL
        ELSE REGEXP_REPLACE(TRIM(vehicle_id), '[^0-9]', '')
    END AS vehicle_id,
    LOWER(TRIM(event_type)) AS event_type,
    UPPER(TRIM(schedule_relationship)) AS schedule_relationship,
    CASE
        WHEN event_time ~ '^[0-9]+$'
        THEN to_timestamp(event_time::bigint) AT TIME ZONE 'UTC'
        ELSE NULL
    END AS event_ts,
    LOWER(TRIM(feed)) AS feed,
    _batch_id,
    _loaded_at::timestamptz AS loaded_at
FROM trip_updates
WHERE trip_id IS NOT NULL
  AND start_date IS NOT NULL
{% if is_incremental() %}
  AND _loaded_at > (SELECT COALESCE(MAX(loaded_at), '1970-01-01') FROM {{ this }})
{% endif %}
;

-- task: trips_history
SELECT
    trip_id,
    route_id,
    service_id,
    direction_id,
    trip_headsign,
    first_departure,
    feed_version,
    CASE
        WHEN length(feed_start_date) = 8
        THEN substr(feed_start_date,1,4) || '-' || substr(feed_start_date,5,2) || '-' || substr(feed_start_date,7,2)
        ELSE NULL
    END AS feed_start_date,
    _batch_id,
    _loaded_at::timestamptz AS loaded_at
FROM trips
WHERE trip_id IS NOT NULL
{% if is_incremental() %}
  AND _loaded_at > (SELECT COALESCE(MAX(loaded_at), '1970-01-01') FROM {{ this }})
{% endif %}
;

-- task: trip_actuals
WITH
trips_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY trip_id, feed_start_date
               ORDER BY loaded_at DESC
           ) AS rn
    FROM trips_history
),
trips_latest AS (
    SELECT * FROM trips_ranked WHERE rn = 1
),

version_bounds AS (
    SELECT
        trip_id,
        route_id,
        first_departure,
        feed_start_date,
        LEAD(feed_start_date) OVER (
            PARTITION BY trip_id
            ORDER BY feed_start_date
        ) AS next_start_date
    FROM trips_latest
),

scheduled AS (
    SELECT
        trip_id,
        route_id,
        feed_start_date,
        next_start_date,
        CASE
            WHEN first_departure ~ '^[0-9]{1,2}:[0-9]{2}:[0-9]{2}$' THEN
                (
                    (feed_start_date::date + 
                     (SPLIT_PART(first_departure, ':', 1)::int / 24) * INTERVAL '1 day'
                    )::timestamp
                    + (SPLIT_PART(first_departure, ':', 1)::int % 24) * INTERVAL '1 hour'
                    + SPLIT_PART(first_departure, ':', 2)::int * INTERVAL '1 minute'
                    + SPLIT_PART(first_departure, ':', 3)::int * INTERVAL '1 second'
                )
                + INTERVAL '7 hours'
            ELSE NULL
        END AS scheduled_start_utc
    FROM version_bounds
),

updates AS (
    SELECT
        trip_id,
        service_date,
        route_id,
        vehicle_id,
        event_type,
        schedule_relationship,
        event_ts,
        feed,
        ROW_NUMBER() OVER (
            PARTITION BY trip_id, service_date
            ORDER BY
                CASE event_type
                    WHEN 'start' THEN 1
                    WHEN 'end'   THEN 2
                    WHEN 'cancel' THEN 3
                    ELSE 9
                END,
                event_ts
        ) AS rn_start,
        FIRST_VALUE(
            CASE
                WHEN event_type = 'cancel' OR schedule_relationship = 'CANCELED' THEN 'cancelled'
                WHEN event_type = 'end'   THEN 'completed'
                WHEN event_type = 'start' THEN 'started'
                ELSE NULL
            END
        ) OVER (
            PARTITION BY trip_id, service_date
            ORDER BY event_ts DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS last_status
    FROM trip_updates_history
    WHERE event_ts IS NOT NULL
),

first_starts AS (
    SELECT
        trip_id,
        service_date,
        route_id AS feed_route_id,
        vehicle_id,
        event_ts AS actual_start,
        last_status AS status
    FROM updates
    WHERE rn_start = 1
      AND event_type = 'start'
),

cancelled AS (
    SELECT DISTINCT
        trip_id,
        service_date,
        route_id AS feed_route_id,
        NULL::text AS vehicle_id,
        NULL::timestamptz AS actual_start,
        'cancelled' AS status
    FROM updates
    WHERE last_status = 'cancelled'
      AND NOT EXISTS (
          SELECT 1 FROM first_starts fs
          WHERE fs.trip_id = updates.trip_id
            AND fs.service_date = updates.service_date
      )
),

actuals AS (
    SELECT * FROM first_starts
    UNION ALL
    SELECT * FROM cancelled
),

joined AS (
    SELECT
        a.trip_id,
        a.service_date,
        COALESCE(s.route_id, a.feed_route_id) AS route_id,
        s.scheduled_start_utc AS scheduled_start,
        a.actual_start,
        CASE
            WHEN a.actual_start IS NOT NULL AND s.scheduled_start_utc IS NOT NULL
            THEN EXTRACT(EPOCH FROM (a.actual_start - s.scheduled_start_utc))::int
            ELSE NULL
        END AS delay_s,
        a.status,
        a.vehicle_id,
        CASE WHEN s.trip_id IS NULL THEN TRUE ELSE FALSE END AS unscheduled
    FROM actuals a
    LEFT JOIN scheduled s
      ON  a.trip_id = s.trip_id
      AND a.service_date >= s.feed_start_date
      AND (s.next_start_date IS NULL OR a.service_date < s.next_start_date)
)

SELECT
    trip_id,
    service_date,
    route_id,
    scheduled_start,
    actual_start,
    delay_s,
    status,
    vehicle_id,
    unscheduled
FROM joined
WHERE status IS NOT NULL
;
