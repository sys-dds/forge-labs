CREATE VIEW daily_signup_metrics AS
SELECT
  event_at::date AS metric_date,
  COUNT(*) FILTER (WHERE event_name = 'signup') AS signup_users,
  COUNT(*) FILTER (WHERE event_name = 'feed_view') AS feed_view_after_signup_users,
  COUNT(*) FILTER (WHERE event_name = 'post_created') AS same_day_post_after_signup_users,
  0::bigint AS next_day_post_after_signup_users
FROM events
GROUP BY event_at::date
ORDER BY metric_date;

