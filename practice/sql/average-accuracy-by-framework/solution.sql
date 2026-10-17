SELECT
  LOWER(framework) AS framework,
  ROUND(AVG(accuracy), 2) AS avg_accuracy
FROM ml_models
WHERE CAST(REPLACE(version, 'v', '') AS REAL) BETWEEN 1.0
AND 2.0
GROUP BY LOWER(framework)
