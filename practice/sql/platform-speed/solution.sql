select d.device_type,
       AVG(us.session_duration_sec) avg_duration,
       MAX(us.session_duration_sec) max_duration,
       count(*) session_count
from user_sessions us
join devices d
on d.device_id=us.device_id
group by d.device_type
LIMIT 4
