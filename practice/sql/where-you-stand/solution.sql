select svc_name,region,latency,AVG(latency) over(partition by region) as avg_region_latency
from svc_health
ORDER BY region ASC, svc_name ASC, latency ASC;
