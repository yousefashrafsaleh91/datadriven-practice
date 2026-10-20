with POST_Method as (
select endpoint,UPPER(method),user_id
from api_calls 
where UPPER(method)='POST'
),
Counts as(
  select endpoint,count(*) call_count
  from POST_Method
  group by endpoint
  order by 2 asc
),
Ranks as(
  select *,dense_rank() over(order by call_count asc) rnk from Counts
)
 select * from Ranks where rnk<=3
