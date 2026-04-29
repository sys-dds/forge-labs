DO $$
DECLARE c integer; first_body text;
BEGIN
  SELECT count(*) INTO c FROM keyset_page_one; IF c <> 2 THEN RAISE EXCEPTION 'first page wrong'; END IF;
  SELECT count(*) INTO c FROM keyset_page_two; IF c <> 2 THEN RAISE EXCEPTION 'second page wrong'; END IF;
  SELECT body INTO first_body FROM stable_ordering LIMIT 1; IF first_body <> 'e' THEN RAISE EXCEPTION 'stable ordering wrong'; END IF;
  SELECT count(*) INTO c FROM stable_ordering WHERE body IN ('a','b'); IF c <> 2 THEN RAISE EXCEPTION 'duplicate timestamp rows missing'; END IF;
END $$;
