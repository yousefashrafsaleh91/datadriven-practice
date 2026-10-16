select t.transaction_id,u.username,t.total_amount,
sum(total_amount) over(order by transaction_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  as running_total 
from transactions t 
join users u 
on t.user_id = u.user_id
where u.username in ('alice','aaron42')
