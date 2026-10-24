select ci.content_type content_type,count(*) as view_count
from content_views cv
JOIN content_items ci
ON cv.content_id=ci.content_id
GROUP BY content_type
