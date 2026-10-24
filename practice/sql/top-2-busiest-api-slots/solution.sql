WITH segmented AS (
  SELECT
    status,
    CASE
      WHEN CAST(STRFTIME('%H', call_time) AS INTEGER) < 12 THEN 'Morning'
      WHEN CAST(STRFTIME('%H', call_time) AS INTEGER) <= 15 THEN 'Early Afternoon'
      ELSE 'Late Afternoon'
    END AS time_segment,
    COUNT(*) AS call_count
  FROM api_calls
  WHERE err_msg IS NOT NULL
  GROUP BY status, time_segment
),
ranked AS (
  SELECT
    *,
    DENSE_RANK() OVER (
      ORDER BY call_count DESC
    ) AS rnk
  FROM segmented
)
  
SELECT status,time_segment,call_count FROM ranked where rnk<4
