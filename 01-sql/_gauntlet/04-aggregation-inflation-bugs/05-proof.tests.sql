DO $$
DECLARE handles text[];
BEGIN
  SELECT array_agg(handle ORDER BY handle) INTO handles FROM gauntlet_result;
  IF handles IS DISTINCT FROM ARRAY['ada','ben']::text[] THEN RAISE EXCEPTION 'expected Ada and Ben only, got %', handles; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE handle='ada' AND post_count=2 AND like_count=2 AND comment_count=2) THEN
    RAISE EXCEPTION 'Ada visible metrics should be posts=2 likes=2 comments=2';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE handle='ben' AND post_count=1 AND like_count=3 AND comment_count=1) THEN
    RAISE EXCEPTION 'Ben metrics should be posts=1 likes=3 comments=1';
  END IF;
END $$;
SELECT 'PASS aggregation gauntlet' AS result;
