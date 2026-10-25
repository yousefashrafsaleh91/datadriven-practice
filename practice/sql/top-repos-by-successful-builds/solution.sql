select repo_name,count(*) as success_count from ci_builds
where status='success'
group by repo_name
order by 2 desc
