WITH monthly_stats AS (
    SELECT 
        DATE_FORMAT(session_start, '%Y-%m') AS month,
        COUNT(DISTINCT user_id) AS active_users,
        COUNT(session_id) AS total_sessions,
        AVG(session_duration_sec) AS avg_duration_sec
    FROM 
        user_sessions
    WHERE 
        session_start >= '2024-09-12' 
        AND session_start < '2026-09-12'
    GROUP BY 
        DATE_FORMAT(session_start, '%Y-%m')
)
SELECT 
    month,
    active_users,
    avg_duration_sec
FROM 
    monthly_stats
WHERE 
    total_sessions > active_users
ORDER BY 
    month ASC;
