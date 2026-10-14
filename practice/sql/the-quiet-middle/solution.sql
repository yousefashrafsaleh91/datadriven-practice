with c as (select job_name,dense_rank()over(order by rows_done desc) as rnk from batch_jobs 
order by rows_done desc
)
select * from c where rnk between 8 and 10
