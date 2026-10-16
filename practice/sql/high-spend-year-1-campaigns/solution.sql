select ad_campaign,
       datepart(year,impression_time) impression_year,
       count(distinct(user_id)) as unique_users
from ad_impressions
group by ad_campaign,datepart(year,impression_time)
having sum(revenue)>5
