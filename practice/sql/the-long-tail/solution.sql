with ranked_latency as (select UPPER(TRIM(method)) method,latency,
row_number()over(partition by UPPER(TRIM(method)) order by latency asc) rn
from api_calls
where latency is not null
)

select method,ROUND(AVG(latency * 1.0), 2) fastest_five_avg
from ranked_latency
where rn <=5
group by method
