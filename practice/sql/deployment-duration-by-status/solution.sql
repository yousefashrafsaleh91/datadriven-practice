select LOWER(TRIM(svc_name)),LOWER(TRIM(status)),sum(dur_secs)
from deploy_logs
group by LOWER(TRIM(svc_name)),LOWER(TRIM(status))
order by 3 desc
