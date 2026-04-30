CREATE OR REPLACE VIEW gauntlet_result AS
WITH clean_events AS (
  SELECT * FROM events WHERE NOT internal
),
signups AS (
  SELECT user_handle, min(occurred_at) AS signup_at FROM clean_events WHERE event_name='signup' GROUP BY user_handle
),
feed_users AS (
  SELECT DISTINCT s.user_handle FROM signups s JOIN clean_events e ON e.user_handle=s.user_handle AND e.event_name='feed_view' AND e.occurred_at > s.signup_at
),
posts AS (
  SELECT s.user_handle, min(e.occurred_at) AS post_at
  FROM signups s JOIN clean_events e ON e.user_handle=s.user_handle AND e.event_name='post_created' AND e.occurred_at > s.signup_at
  GROUP BY s.user_handle
)
SELECT
  (SELECT count(*)::integer FROM signups) AS signup_count,
  (SELECT count(*)::integer FROM feed_users) AS feed_view_after_signup_count,
  (SELECT count(*)::integer FROM posts p JOIN signups s ON s.user_handle=p.user_handle WHERE p.post_at::date=s.signup_at::date) AS same_day_post_after_signup_count,
  (SELECT count(*)::integer FROM posts p JOIN signups s ON s.user_handle=p.user_handle WHERE p.post_at::date=s.signup_at::date + integer '1') AS next_day_post_after_signup_count;
