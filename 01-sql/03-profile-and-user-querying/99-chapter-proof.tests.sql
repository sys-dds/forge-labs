DO $$
DECLARE r record; handles text[]; email_columns integer; missing_count integer;
BEGIN
  SELECT * INTO r FROM profile_card WHERE handle = 'ada';
  IF r.post_count <> 2 OR r.follower_count <> 2 OR r.following_count <> 1 THEN
    RAISE EXCEPTION 'Ada card expected 2/2/1 got %/%/%', r.post_count, r.follower_count, r.following_count;
  END IF;
  SELECT count(*) INTO email_columns FROM information_schema.columns WHERE table_name = 'public_profile_by_handle' AND column_name = 'email';
  IF email_columns <> 0 THEN RAISE EXCEPTION 'public profile view must not expose email'; END IF;
  SELECT array_agg(handle ORDER BY handle) INTO handles FROM search_profiles;
  IF handles <> ARRAY['ada','diya'] THEN RAISE EXCEPTION 'public search expected ada,diya got %', handles; END IF;
  IF EXISTS (SELECT 1 FROM search_profiles WHERE handle = 'cy') THEN RAISE EXCEPTION 'non-searchable Cy appeared in search'; END IF;
  SELECT count(*) INTO missing_count FROM public_profile_by_handle WHERE handle = 'missing';
  IF missing_count <> 0 THEN RAISE EXCEPTION 'missing handle should return zero rows'; END IF;
END $$;

