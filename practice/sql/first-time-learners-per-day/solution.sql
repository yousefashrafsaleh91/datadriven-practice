WITH sessions as (
SELECT 
  DATE(session_start) Day,
  row_number() OVER(
   PARTITION BY user_id 
   ORDER BY session_start
   ) rn 
 FROM user_sessions 
 ORDER BY session_start ASC
)
 
 select Day,count(rn) new_user_count from sessions where rn =1 group by Day
