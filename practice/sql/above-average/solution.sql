with res as (
select product_name,category,price,AVG(price) over()  as catalog_avg
from products 
)
select * from res 
where price >catalog_avg
order by price desc
