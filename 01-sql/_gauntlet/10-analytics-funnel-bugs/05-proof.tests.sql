DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM gauntlet_result
    WHERE signup_count=4 AND feed_view_after_signup_count=3 AND same_day_post_after_signup_count=1 AND next_day_post_after_signup_count=1
  ) THEN
    RAISE EXCEPTION 'funnel counts should be signup=4 feed=3 same_day_post=1 next_day_post=1';
  END IF;
END $$;
SELECT 'PASS analytics funnel gauntlet' AS result;
