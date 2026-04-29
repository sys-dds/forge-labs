DO $$
DECLARE ids integer[]; cursor_count integer;
BEGIN
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO ids FROM keyset_page_one;
  IF ids <> ARRAY[106,105,104] THEN RAISE EXCEPTION 'expected keyset page one 106,105,104 got %', ids; END IF;
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO ids FROM keyset_page_two;
  IF ids <> ARRAY[103,102,101] THEN RAISE EXCEPTION 'expected keyset page two 103,102,101 got %', ids; END IF;
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO ids FROM stable_timestamp_ties;
  IF ids <> ARRAY[105,104] THEN RAISE EXCEPTION 'timestamp tie should order 105,104 got %', ids; END IF;
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO ids FROM offset_page_two_after_insert;
  IF ids <> ARRAY[104,103,102] THEN RAISE EXCEPTION 'expected offset after insert to repeat 104 got %', ids; END IF;
  SELECT count(*) INTO cursor_count FROM feed_cursor_shape WHERE last_seen_id = 104 AND last_seen_created_at = '2026-01-01 10:05:00+00'::timestamptz;
  IF cursor_count <> 1 THEN RAISE EXCEPTION 'cursor shape should expose created_at and id for row 104'; END IF;
END $$;

