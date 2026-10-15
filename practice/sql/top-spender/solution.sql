select username,sum(total_amount) as total_spend 
from users u
JOIN transactions t
ON  u.user_id=t.user_id
JOIN products p
ON p.product_id=t.product_id
where p.rating>=4
group by username
order by 2 desc
limit 13
