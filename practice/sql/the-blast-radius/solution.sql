SELECT
  d.author,
  ROUND(AVG(h.latency), 2) AS avg_latency
FROM deploy_logs AS d
INNER JOIN svc_health AS h
  ON d.svc_name = h.svc_name
GROUP BY LOWER(d.author)
ORDER BY avg_latency DESC
