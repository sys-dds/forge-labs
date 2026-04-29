DO $$
DECLARE c integer;
BEGIN
  SELECT count(*) INTO c FROM feed_candidates; IF c <> 2 THEN RAISE EXCEPTION 'expected 2 visible feed candidates, got %', c; END IF;
  SELECT count(*) INTO c FROM feed_candidates WHERE handle NOT IN ('grace'); IF c <> 0 THEN RAISE EXCEPTION 'feed included non-visible author'; END IF;
  SELECT count(*) INTO c FROM feed_candidates WHERE display_name IS NULL; IF c <> 0 THEN RAISE EXCEPTION 'author profile missing'; END IF;
  SELECT count(*) INTO c FROM row_multiplication_bad; IF c <= 2 THEN RAISE EXCEPTION 'bad multiplication example did not multiply rows'; END IF;
  SELECT like_count + comment_count INTO c FROM row_multiplication_fixed; IF c <> 4 THEN RAISE EXCEPTION 'fixed metrics wrong'; END IF;
END $$;
