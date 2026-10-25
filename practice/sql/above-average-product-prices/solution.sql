with bases as (
select product_id,min(total_amount) base_price,AVG(total_amount) over() avg from transactions
--where base_price > win
group by product_id
)

select product_id,base_price from bases
where base_price>avg
