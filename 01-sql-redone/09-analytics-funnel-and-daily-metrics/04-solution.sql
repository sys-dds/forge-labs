CREATE VIEW daily_signup_metrics AS
WITH non_internal_events AS (
  SELECT e.*
  FROM events e
  JOIN users u ON u.id = e.user_id
  WHERE u.is_internal = false
),
first_signups AS (
  SELECT user_id, MIN(event_at) AS signup_at
  FROM non_internal_events
  WHERE event_name = 'signup'
  GROUP BY user_id
),
signup_dates AS (
  SELECT user_id, signup_at, signup_at::date AS signup_date
  FROM first_signups
),
user_funnel AS (
  SELECT
    s.user_id,
    s.signup_date,
    EXISTS (
      SELECT 1 FROM non_internal_events e
      WHERE e.user_id = s.user_id
        AND e.event_name = 'feed_view'
        AND e.event_at >= s.signup_at
    ) AS viewed_feed_after_signup,
    EXISTS (
      SELECT 1 FROM non_internal_events e
      WHERE e.user_id = s.user_id
        AND e.event_name = 'post_created'
        AND e.event_at >= s.signup_at
        AND e.event_at::date = s.signup_date
    ) AS posted_same_day_after_signup,
    EXISTS (
      SELECT 1 FROM non_internal_events e
      WHERE e.user_id = s.user_id
        AND e.event_name = 'post_created'
        AND e.event_at >= s.signup_at
        AND e.event_at::date = s.signup_date + 1
    ) AS posted_next_day_after_signup
  FROM signup_dates s
)
SELECT
  signup_date AS metric_date,
  COUNT(*) AS signup_users,
  COUNT(*) FILTER (WHERE viewed_feed_after_signup) AS feed_view_after_signup_users,
  COUNT(*) FILTER (WHERE posted_same_day_after_signup) AS same_day_post_after_signup_users,
  COUNT(*) FILTER (WHERE posted_next_day_after_signup) AS next_day_post_after_signup_users
FROM user_funnel
GROUP BY signup_date
ORDER BY signup_date;

