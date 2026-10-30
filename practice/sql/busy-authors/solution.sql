select trim(lower(author)),count(*),count(distinct(repo_name)) from repo_commits
where message is not null
group by trim(lower(author))
having count(*)>=24
