SELECT
  issued AS the_date,
  COUNT(*) active_day0,case when expires<=issued+ interval 7 Day then 0 else 1 end active_day7

FROM api_tokens
WHERE LOWER(TRIM(scope)) = 'write'
  AND LOWER(TRIM(status)) = 'active'
  AND requests > 1
  GROUP BY issued
ORDER BY the_date
limit 7
