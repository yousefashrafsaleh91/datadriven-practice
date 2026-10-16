select content_type,
       count(content_id) items_published ,
       AVG(duration_seconds) avg_runtime
from content_items
group by content_type
order by 3 desc
