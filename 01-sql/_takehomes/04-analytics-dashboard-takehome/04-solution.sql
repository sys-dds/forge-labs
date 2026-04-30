CREATE OR REPLACE VIEW daily_dashboard AS
WITH clean_events AS (
  SELECT * FROM events WHERE NOT internal
),
signups AS (
  SELECT user_handle, min(occurred_at) AS signup_at FROM clean_events WHERE event_name='signup' GROUP BY user_handle
),
daily_active AS (
  SELECT occurred_at::date AS day, count(DISTINCT user_handle)::integer AS daily_active_users
  FROM clean_events GROUP BY occurred_at::date
),
daily_signups AS (
  SELECT signup_at::date AS day, count(*)::integer AS signup_count
  FROM signups GROUP BY signup_at::date
),
daily_posts AS (
  SELECT occurred_at::date AS day, count(*)::integer AS posts_created
  FROM clean_events WHERE event_name='post_created' GROUP BY occurred_at::date
),
same_day_posts AS (
  SELECT DISTINCT s.user_handle, s.signup_at::date AS day
  FROM signups s JOIN clean_events e ON e.user_handle=s.user_handle AND e.event_name='post_created' AND e.occurred_at::date=s.signup_at::date AND e.occurred_at>s.signup_at
),
same_day_counts AS (
  SELECT day, count(*)::integer AS same_day_signup_post_count
  FROM same_day_posts GROUP BY day
)
SELECT d.day,
  coalesce(daily_active.daily_active_users,0) AS daily_active_users,
  coalesce(daily_signups.signup_count,0) AS signup_count,
  coalesce(daily_posts.posts_created,0) AS posts_created,
  coalesce(same_day_counts.same_day_signup_post_count,0) AS same_day_signup_post_count
FROM calendar_days d
LEFT JOIN daily_active ON daily_active.day=d.day
LEFT JOIN daily_signups ON daily_signups.day=d.day
LEFT JOIN daily_posts ON daily_posts.day=d.day
LEFT JOIN same_day_counts ON same_day_counts.day=d.day
ORDER BY d.day;
