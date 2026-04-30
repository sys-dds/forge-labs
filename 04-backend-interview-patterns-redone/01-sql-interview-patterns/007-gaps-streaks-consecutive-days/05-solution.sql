SET search_path TO bip_sql_007;
WITH days AS (
  SELECT DISTINCT u.user_id, u.user_name, e.practiced_at::date AS practice_day
  FROM users u
  LEFT JOIN practice_events e ON e.user_id = u.user_id
  WHERE u.active = true
), numbered AS (
  SELECT user_id, user_name, practice_day,
         practice_day - (ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY practice_day))::int AS streak_group
  FROM days
  WHERE practice_day IS NOT NULL
), streaks AS (
  SELECT user_id, user_name, COUNT(*) AS streak_length
  FROM numbered
  GROUP BY user_id, user_name, streak_group
)
SELECT u.user_id, u.user_name, COALESCE(MAX(s.streak_length), 0) AS longest_streak_days
FROM users u
LEFT JOIN streaks s ON s.user_id = u.user_id
WHERE u.active = true
GROUP BY u.user_id, u.user_name
ORDER BY u.user_id;
