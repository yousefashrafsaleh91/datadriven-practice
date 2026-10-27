WITH tiers AS (
SELECT
  svc_name,
  SUM(amount) total_spend,
  NTILE(4) OVER(ORDER BY SUM(amount) ASC) AS tier
FROM cloud_costs
WHERE year(bill_date) = 2026 AND month(bill_date) = 5
GROUP BY svc_name
)
SELECT svc_name,total_spend FROM tiers where tier=1
