select top(5) product_name,
       category,
       round(price,3) as price,
       in_stock
 from products
 where price is not null 
 order by 3 asc
