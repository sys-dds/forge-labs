DO $$
DECLARE latest integer[];
BEGIN
  SELECT array_agg(id ORDER BY author) INTO latest FROM gauntlet_latest_posts;
  IF latest IS DISTINCT FROM ARRAY[103,202,301]::integer[] THEN RAISE EXCEPTION 'latest posts should be {103,202,301}, got %', latest; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_ranked_posts WHERE id=202 AND rank_label=5 AND dense_rank_label=3) THEN RAISE EXCEPTION 'rank gap and dense-rank no-gap labels are wrong for post 202'; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_running_totals WHERE author='ada' AND event_id=2 AND running_points=5) THEN RAISE EXCEPTION 'Ada running total should be partitioned to 5'; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_running_totals WHERE author='ben' AND event_id=4 AND running_points=5) THEN RAISE EXCEPTION 'Ben running total should be partitioned to 5'; END IF;
END $$;
SELECT 'PASS window ranking gauntlet' AS result;
