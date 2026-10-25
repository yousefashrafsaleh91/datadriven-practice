select count(*) fail_count from dq_checks 
where lower(trim(rule))='not_null' and passed=0
