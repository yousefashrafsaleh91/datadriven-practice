SELECT

y.user_id user_id_1,

x.user_id user_id_2

FROM users AS x

JOIN users AS y

ON y.account_status = x.account_status

AND y.user_id < x.user_id

AND YEAR(y.signup_date) <> YEAR(x.signup_date)

AND y.age_bucket <> x.age_bucket

ORDER BY y.user_id
