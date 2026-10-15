with allsales as (
select p.category,
        p.product_name,
        sum(round(t.total_amount::numeric ,3)) total_revenue

from transactions t

join products p
on t.product_id = p.product_id

where year(t.transaction_date)=2026
group by p.product_name,p.category

order by 3 desc 
),
highest as (
  select category,
         product_name,
         total_revenue,
         row_number() over(partition by category order by total_revenue desc) as rnk
  from allsales 
)
 select category,product_name,total_revenue from highest
 where rnk =1
 order by 3 desc
