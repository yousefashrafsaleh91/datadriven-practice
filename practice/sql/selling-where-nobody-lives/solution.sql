select distinct(region) from orders
where status in ('Shipped','Completed') and profit>=1200 and region is not null
