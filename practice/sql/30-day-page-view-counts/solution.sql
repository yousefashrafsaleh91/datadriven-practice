select user_id,count(*) as total_views from page_views 
where viewed_at between "2025-01-01 00:00:00" and "2025-12-28 23:59:59"
group by user_id
