with cleaned as (select job_id,lower(status) status,started,ended from batch_jobs
where ended is not null and started is not null and lower(status)='completed'

)
,events AS (
  SELECT job_id,started AS ts,  1 AS delta FROM cleaned
  UNION ALL
  SELECT job_id,ended   AS ts, -1 AS delta FROM cleaned
),

ordered AS (
  SELECT
    job_id,ts,
    delta,
    SUM(delta) OVER (
      ORDER BY ts, delta          
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS concurrent
  FROM events
)
SELECT MAX(concurrent) as min_workers
FROM ordered;
