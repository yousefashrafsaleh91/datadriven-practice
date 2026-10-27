select p.product_name,sum(total_amount) as total_revenue
from products p
join transactions t
on p.product_id = t.product_id
group by p.product_name
order by 2 desc
limit 5
