with transformated as (
select cost_id,
       Trim(upper(provider)) as provider,
       amount,dense_rank() over (order by amount desc) as rn
from cloud_costs
)

select distinct amount from transformated limit 3
