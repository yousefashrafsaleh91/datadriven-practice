SELECT 
    d.author,
    -- حساب متوسط الـ latency وتقريبه لرقمين عشريين
    ROUND(AVG(h.latency), 2) AS avg_latency
FROM 
    deploy_logs d
INNER JOIN 
    svc_health h ON d.svc_name = h.svc_name
GROUP BY 
    TRIM(LOWER(d.author))
ORDER BY 
    avg_latency DESC;
