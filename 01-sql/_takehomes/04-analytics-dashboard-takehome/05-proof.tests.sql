DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM daily_dashboard WHERE day='2026-04-29' AND daily_active_users=4 AND signup_count=4 AND posts_created=1 AND same_day_signup_post_count=1) THEN RAISE EXCEPTION 'April 29 dashboard wrong'; END IF;
  IF NOT EXISTS (SELECT 1 FROM daily_dashboard WHERE day='2026-04-30' AND daily_active_users=1 AND signup_count=0 AND posts_created=1 AND same_day_signup_post_count=0) THEN RAISE EXCEPTION 'April 30 dashboard wrong'; END IF;
END $$;
SELECT 'PASS analytics dashboard take-home' AS result;
