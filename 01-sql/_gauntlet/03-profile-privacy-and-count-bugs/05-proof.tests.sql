DO $$
DECLARE search_handles text[]; has_email integer;
BEGIN
  SELECT count(*) INTO has_email FROM information_schema.columns WHERE table_schema='public' AND table_name='gauntlet_profile_card' AND column_name='email';
  IF has_email <> 0 THEN RAISE EXCEPTION 'public profile card exposes email column'; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_profile_card WHERE handle='ada' AND post_count=2 AND follower_count=2 AND following_count=1) THEN
    RAISE EXCEPTION 'Ada profile counts should be posts=2 followers=2 following=1';
  END IF;
  SELECT array_agg(handle ORDER BY handle) INTO search_handles FROM gauntlet_search_results;
  IF search_handles IS DISTINCT FROM ARRAY['ada','ben','diya']::text[] THEN
    RAISE EXCEPTION 'search handles should exclude private Cy, got %', search_handles;
  END IF;
  IF EXISTS (SELECT 1 FROM gauntlet_search_results WHERE handle='missing') THEN
    RAISE EXCEPTION 'missing handle returned a row';
  END IF;
END $$;
SELECT 'PASS profile privacy gauntlet' AS result;
