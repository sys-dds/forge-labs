DO $$
DECLARE c integer; cols integer;
BEGIN
  SELECT post_count INTO c FROM profile_card_with_counts WHERE handle='ada'; IF c <> 2 THEN RAISE EXCEPTION 'expected 2 posts, got %', c; END IF;
  SELECT follower_count INTO c FROM profile_card_with_counts WHERE handle='ada'; IF c <> 2 THEN RAISE EXCEPTION 'expected 2 followers, got %', c; END IF;
  SELECT count(*) INTO cols FROM information_schema.columns WHERE table_name='public_profile_by_handle' AND column_name='email'; IF cols <> 0 THEN RAISE EXCEPTION 'public query exposed email'; END IF;
  SELECT count(*) INTO c FROM search_profiles WHERE handle='ada'; IF c <> 1 THEN RAISE EXCEPTION 'search should find ada'; END IF;
  SELECT count(*) INTO c FROM users u JOIN profiles p ON p.user_id=u.id WHERE u.handle='missing'; IF c <> 0 THEN RAISE EXCEPTION 'missing handle should return zero'; END IF;
END $$;
