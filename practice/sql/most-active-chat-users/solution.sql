with CountSenders AS (select sender_id,count(reply_to) reply_count  from chat_msgs
where reply_to is not null
group by sender_id)
,AllUsers as (
select dense_rank() over (order by coalesce(cs.reply_count,0) desc ) standing,cm.sender_id,coalesce(cs.reply_count,0) reply_count
from chat_msgs cm
left join CountSenders CS
on cm.sender_id=cs.sender_id
--where cm.reply_to is not null
group by cm.sender_id
order by 1 asc
)

select * from AllUsers 
--select count(*) from chat_msgs
