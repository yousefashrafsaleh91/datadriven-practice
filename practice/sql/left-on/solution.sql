SELECT
  flag_name,
  owner,
  CASE WHEN enabled = 0 THEN 'No' ELSE 'Yes' END still_enabled,
  DATEDIFF(day, created, '2026-05-01') / 365 as years_since_creation
FROM feat_flags
WHERE created <= '2024-05-01'
order by flag_name asc,owner asc,years_since_creation desc
