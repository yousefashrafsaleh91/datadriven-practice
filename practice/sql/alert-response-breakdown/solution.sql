select svc_name,
       count(*) as total_alerts,
       sum(case when LOWER(TRIM(severity))='critical' then 1 else 0 end) critical_count,
       sum(case when LOWER(TRIM(severity))='high' then 1 else 0 end) high_count,
       sum(case when ack_by is NULL then 1 else 0 end) unacked_count,
       round(count(*),2) avg_pwer_status
from alert_events
group by svc_name
order by 2 desc,1 asc
