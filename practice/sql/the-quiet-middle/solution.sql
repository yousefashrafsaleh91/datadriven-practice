with c as (
        select job_name,
        dense_rank() over(order by rows_done desc) as rnk 
        from batch_jobs 
)
select * from c where rnk between 8 and 10
