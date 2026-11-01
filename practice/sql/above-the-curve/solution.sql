WITH user_totals AS (
    SELECT 
        user_id,
        SUM(total_amount) AS total_spend
    FROM 
        transactions
    GROUP BY 
        user_id
),
benchmark AS (
    SELECT 
        AVG(total_spend) AS avg_spend
    FROM 
        user_totals
)
SELECT 
    ut.user_id,
    ut.total_spend,
    (ut.total_spend - b.avg_spend) AS amount_above_average
FROM 
    user_totals ut
CROSS JOIN 
    benchmark b
WHERE 
    ut.total_spend > b.avg_spend
ORDER BY 
    ut.total_spend DESC;
