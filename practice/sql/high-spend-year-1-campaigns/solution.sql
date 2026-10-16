select ad_campaign,
       datepart(year,impression_time),
       count(distinct(user_id))
from ad_impressions
group by ad_campaign,datepart(year,impression_time)
having sum(revenue)>5
