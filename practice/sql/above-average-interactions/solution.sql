with sessions as (select user_id,count(*) as total_sessions from user_sessions
group by user_id
order by 2 desc,1 asc
)

select * from sessions 
where total_sessions>(select AVG(total_sessions) from sessions)
