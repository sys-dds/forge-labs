DO $$
DECLARE
  c integer;
  cols integer;
  card record;
BEGIN
  SELECT * INTO card FROM profile_card_with_counts WHERE handle='ada';
  IF card.post_count <> 2 OR card.follower_count <> 2 OR card.following_count <> 1 THEN
    RAISE EXCEPTION 'profile card counts wrong: posts %, followers %, following %', card.post_count, card.follower_count, card.following_count;
  END IF;

  SELECT count(*) INTO cols
  FROM information_schema.columns
  WHERE table_name='public_profile_by_handle'
    AND column_name='email';
  IF cols <> 0 THEN RAISE EXCEPTION 'public query exposed email'; END IF;

  SELECT count(*) INTO c FROM search_profiles WHERE handle='ada';
  IF c <> 1 THEN RAISE EXCEPTION 'search should find ada'; END IF;

  SELECT count(*) INTO c FROM search_profiles WHERE handle='linus';
  IF c <> 0 THEN RAISE EXCEPTION 'private profile should not appear in public search'; END IF;

  SELECT count(*) INTO c FROM users u JOIN profiles p ON p.user_id=u.id WHERE u.handle='missing';
  IF c <> 0 THEN RAISE EXCEPTION 'missing handle should return zero'; END IF;
END $$;
