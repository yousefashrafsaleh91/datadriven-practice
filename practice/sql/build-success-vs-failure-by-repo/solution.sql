select repo_name,
       sum(case when status ='success' then 1 else 0 end) success_count, 
       sum(case when status ='failure' then 1 else 0 end) failure_count,
       AVG(dur_secs) avg_duration
from ci_builds
GROUP BY repo_name
