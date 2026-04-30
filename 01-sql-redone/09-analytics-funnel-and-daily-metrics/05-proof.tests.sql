CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_metrics (
  metric_date date,
  signup_users bigint,
  feed_view_after_signup_users bigint,
  same_day_post_after_signup_users bigint,
  next_day_post_after_signup_users bigint
);

INSERT INTO expected_metrics VALUES
  ('2026-01-01', 4, 2, 1, 1),
  ('2026-01-02', 1, 0, 0, 0);

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_metrics EXCEPT SELECT * FROM daily_signup_metrics)
  UNION ALL
  (SELECT * FROM daily_signup_metrics EXCEPT SELECT * FROM expected_metrics)
) THEN 1 ELSE fail_test('expected daily signup metrics 2026-01-01={4,2,1,1} and 2026-01-02={1,0,0,0}; broken query counted raw events, Noor, Cy duplicate, or Diya feed view') END AS exact_daily_metrics;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM daily_signup_metrics
  WHERE metric_date = '2026-01-01' AND signup_users = 4
) THEN 1 ELSE fail_test('Cy duplicate signup was counted twice or Noor leaked') END AS cy_counted_once;

SELECT CASE WHEN NOT EXISTS (
  SELECT 1
  FROM daily_signup_metrics
  WHERE metric_date = '2026-01-01' AND signup_users > 4
) THEN 1 ELSE fail_test('Noor internal event leaked into signup count') END AS noor_excluded;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM daily_signup_metrics
  WHERE metric_date = '2026-01-01' AND feed_view_after_signup_users = 2
) THEN 1 ELSE fail_test('Diya feed view counted without signup or Ben/Ada missing') END AS diya_not_feed_after_signup;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM daily_signup_metrics
  WHERE metric_date = '2026-01-01' AND same_day_post_after_signup_users = 1
) THEN 1 ELSE fail_test('Ada same-day post conversion missing') END AS ada_same_day_post;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM daily_signup_metrics
  WHERE metric_date = '2026-01-01' AND next_day_post_after_signup_users = 1
) THEN 1 ELSE fail_test('Maya next-day post conversion missing') END AS maya_next_day_post;
