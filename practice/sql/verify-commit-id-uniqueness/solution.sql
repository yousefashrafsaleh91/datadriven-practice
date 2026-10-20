select 
      count(*) total_commits,
      count(distinct lower(trim(author))) distinct_authors
from repo_commits
