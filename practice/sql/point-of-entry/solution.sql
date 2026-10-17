WITH first_events AS (
  SELECT
    user_id,
    event_type,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY event_timestamp
    ) AS rn
  FROM event_data
),
viewer_cohort AS (
  SELECT
    user_id
  FROM first_events
  WHERE rn = 1
    AND event_type = 'page_view'
)

SELECT
  vc.user_id,count(e.event_type) as cnt
FROM viewer_cohort AS vc
LEFT JOIN event_data AS e
  ON vc.user_id = e.user_id
    AND e.event_type = 'purchase'
group by vc.user_id
ORDER BY 2 DESC
