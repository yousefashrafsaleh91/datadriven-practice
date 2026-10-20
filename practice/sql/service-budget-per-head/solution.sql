WITH billing_vol AS (
  SELECT
    svc_name,
    COUNT(*) AS n_lines          -- billing volume (every allocation $ is multiplied by this)
  FROM cloud_costs
  GROUP BY svc_name
),
norm_allocs AS (
  SELECT
    svc_name,
    LOWER(team_name) AS team_key, -- case-insensitive team identity
    SUM(amount) AS alloc_amt
  FROM cost_allocs
  GROUP BY svc_name, LOWER(team_name)
),
svc_exposure AS (
  SELECT
    a.svc_name,
    COUNT(DISTINCT a.team_key) AS n_teams,
    SUM(a.alloc_amt) AS total_alloc
  FROM norm_allocs a
  GROUP BY a.svc_name
)
SELECT
  e.svc_name,
  ROUND( (e.total_alloc * b.n_lines) * 1.0 / e.n_teams )::bigint AS budget_per_head
FROM svc_exposure e
INNER JOIN billing_vol b
  ON e.svc_name = b.svc_name     -- services with zero billing lines are dropped
ORDER BY e.svc_name;
