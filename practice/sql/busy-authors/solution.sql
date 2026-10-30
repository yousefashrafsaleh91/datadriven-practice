select trim(lower(author)),count(commit_id),count(distinct(repo_name)) from repo_commits
where message is not null
group by trim(lower(author))
having count(commit_id)>=24
