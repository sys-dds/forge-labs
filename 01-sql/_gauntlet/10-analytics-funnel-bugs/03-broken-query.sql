CREATE OR REPLACE VIEW gauntlet_result AS
SELECT
  count(*) FILTER (WHERE event_name='signup')::integer AS signup_count,
  count(*) FILTER (WHERE event_name='feed_view')::integer AS feed_view_after_signup_count,
  count(*) FILTER (WHERE event_name='post_created' AND occurred_at::date='2026-04-29')::integer AS same_day_post_after_signup_count,
  count(*) FILTER (WHERE event_name='post_created' AND occurred_at::date='2026-04-30')::integer AS next_day_post_after_signup_count
FROM events;
