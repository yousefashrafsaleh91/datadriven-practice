WITH TotalSales_2026 AS (
  --Get the total Sales for each (category,product-for all products in thi Cat-)
  SELECT
    p.category,
    p.product_name,
    SUM(ROUND(CAST(t.total_amount AS NUMERIC), 3)) AS total_revenue
  FROM transactions AS t
  JOIN products AS p
    ON t.product_id = p.product_id
  WHERE YEAR(t.transaction_date) = 2026
  GROUP BY p.product_name, p.category
  ORDER BY 3 DESC
),
highest AS (
  -- Get the highest (Category,Product) Total Sales
  SELECT
    category,
    product_name,
    total_revenue,
    ROW_NUMBER() OVER (
      PARTITION BY category
      ORDER BY total_revenue DESC
    ) AS rnk
  FROM TotalSales_2026
)

SELECT
  category,
  product_name,
  total_revenue
FROM highest
WHERE rnk = 1
ORDER BY 3 DESC
