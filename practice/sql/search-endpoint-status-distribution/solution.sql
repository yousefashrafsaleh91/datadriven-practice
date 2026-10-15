select status,count(call_id)
from api_calls 
where endpoint='/api/v1/search'
group by status
