with cc  as (
select user_id,event_type,event_timestamp ,
row_number() over(partition by user_id order by event_timestamp asc) rn
from event_data 
)

select user_id  , count(*) purchase_count from cc
where event_type='purchase' and user_id in (select coalesce(user_id,'anonymous') from cc where event_type ='page_view' and rn =1)
group by user_id
union all
select NULL user_id  ,0 purchase_count  from cc
where event_type='purchase' 
group by NULL
order by 2 desc
