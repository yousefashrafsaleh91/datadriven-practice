SELECT
  DENSE_RANK() OVER (
    ORDER BY COUNT(reply_to) DESC
  ) AS standing,
  sender_id,
  COUNT(reply_to) AS reply_count
FROM chat_msgs
GROUP BY sender_id
ORDER BY standing
