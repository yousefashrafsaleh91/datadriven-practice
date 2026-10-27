SELECT
  u1.user_id AS user_id_1,
  u2.user_id AS user_id_2
FROM users AS u1
JOIN users AS u2
  ON u1.user_id < u2.user_id
WHERE u1.age_bucket <> u2.age_bucket
  AND u1.account_status = u2.account_status
  AND STRFTIME('%Y', u1.signup_date) <> STRFTIME('%Y', u2.signup_date)
