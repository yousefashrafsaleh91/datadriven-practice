with transformed as (
select svc_name,
  left(replace(replace(REGEXP_REPLACE(version,'[a-z]',''),'.',''),'-',''),3)
from deploy_logs
where env_name='staging'
)
select * from transformed
