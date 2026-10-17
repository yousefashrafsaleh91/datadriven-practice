select edge_loc,req_path,SUM(bytes) total_bytes from cdn_logs

where req_path like '%api%' and edge_loc in (select distinct edge_loc from cdn_logs where cache_hit=1 and req_path like '%api%')
group by edge_loc,req_path
