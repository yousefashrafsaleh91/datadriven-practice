with apis as (select status,case 
when hour(call_time) <12 then 'Morning' 
when hour(call_time) < 15 then 'Early Afternoon'
 else 'Late Afternoon' end as time_segment
from api_calls 
where err_msg is not null)


select status,time_segment,count(*) as call_count 
from apis 
group by status,time_segment
having count(*)>=3
order by 3 desc
