WITH TxnCount AS(
SELECT u.username,
  COUNT(*) AS txn_count ,dense_rank()over(order by COUNT(*)desc) teir
FROM users AS u 
JOIN transactions AS t 
ON u.user_id = t.user_id 
WHERE t.total_amount > 0 
GROUP BY u.username 
ORDER BY 2 DESC
)

select * from TxnCount
where teir <=2
