DO $$
DECLARE
  ids text;
  first_body text;
BEGIN
  SELECT string_agg(id::text, ',' ORDER BY created_at DESC, id DESC) INTO ids FROM keyset_page_one;
  IF ids <> '5,4' THEN RAISE EXCEPTION 'first page exact ids wrong: %', ids; END IF;

  SELECT string_agg(id::text, ',' ORDER BY created_at DESC, id DESC) INTO ids FROM keyset_page_two;
  IF ids <> '3,2' THEN RAISE EXCEPTION 'second page exact ids wrong: %', ids; END IF;

  SELECT string_agg(id::text, ',' ORDER BY id DESC) INTO ids FROM stable_ordering WHERE body IN ('a','b');
  IF ids <> '2,1' THEN RAISE EXCEPTION 'duplicate timestamp tie-breaker wrong: %', ids; END IF;

  SELECT body INTO first_body FROM stable_ordering LIMIT 1;
  IF first_body <> 'e' THEN RAISE EXCEPTION 'stable ordering first row wrong'; END IF;
END $$;
