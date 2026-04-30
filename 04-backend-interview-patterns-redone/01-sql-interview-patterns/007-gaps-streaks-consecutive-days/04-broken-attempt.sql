SET search_path TO bip_sql_007;
SELECT u.user_id, u.user_name, COUNT(DISTINCT e.practiced_at::date) AS longest_streak_days
FROM users u
LEFT JOIN practice_events e ON e.user_id = u.user_id
WHERE u.active = true
GROUP BY u.user_id, u.user_name
ORDER BY u.user_id;
