with ranks as (
select token_id,
scope,
requests::numeric requests,
round(PERCENT_RANK() 
over(partition by scope order by requests)::numeric,2)  as percentile_rank
from api_tokens
)

select * from ranks where percentile_rank>=0.95 order by scope asc,3 desc,1 asc
