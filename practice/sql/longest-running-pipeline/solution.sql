with longest as (select pipe_name,sum(coalesce(dur_secs,0)) from data_pipes
group by pipe_name
order by 2 desc)
select pipe_name from longest limit 1
