DO $$
DECLARE
  page_one integer[];
  page_two integer[];
  offset_two integer[];
  duplicate_pair integer[];
  cursor_created_at timestamp;
  cursor_id integer;
BEGIN
  SELECT array_agg(id ORDER BY created_at DESC, id DESC)
  INTO page_one
  FROM keyset_page_one;

  IF page_one IS DISTINCT FROM ARRAY[107, 106]::integer[] THEN
    RAISE EXCEPTION 'Keyset page one mismatch: expected {107,106}, got %', page_one;
  END IF;

  SELECT array_agg(id ORDER BY created_at DESC, id DESC)
  INTO page_two
  FROM keyset_page_two;

  IF page_two IS DISTINCT FROM ARRAY[105, 104]::integer[] THEN
    RAISE EXCEPTION 'Keyset page two mismatch: expected {105,104}, got %', page_two;
  END IF;

  SELECT last_seen_created_at, last_seen_id
  INTO cursor_created_at, cursor_id
  FROM scroll_cursor;

  IF cursor_created_at <> '2026-04-29 10:05:00'::timestamp OR cursor_id <> 106 THEN
    RAISE EXCEPTION 'Cursor should carry created_at 10:05 and id 106, got %, %', cursor_created_at, cursor_id;
  END IF;

  SELECT array_agg(id ORDER BY created_at DESC, id DESC)
  INTO duplicate_pair
  FROM feed_posts
  WHERE created_at = '2026-04-29 10:04:00'::timestamp;

  IF duplicate_pair IS DISTINCT FROM ARRAY[105, 104]::integer[] THEN
    RAISE EXCEPTION 'Duplicate timestamp rows are not ordered by id DESC: got %', duplicate_pair;
  END IF;

  SELECT array_agg(id ORDER BY created_at DESC, id DESC)
  INTO offset_two
  FROM offset_page_two_after_insert;

  IF offset_two IS DISTINCT FROM ARRAY[106, 105]::integer[] THEN
    RAISE EXCEPTION 'Offset example should repeat 106 after insert and then return 105, got %', offset_two;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM offset_page_two_after_insert WHERE id = 106) THEN
    RAISE EXCEPTION 'Offset page two did not demonstrate the repeated row 106';
  END IF;

  IF EXISTS (SELECT 1 FROM created_at_only_cursor_page_two WHERE id = 104) THEN
    RAISE EXCEPTION 'Created-at-only cursor unexpectedly kept duplicate timestamp row 104';
  END IF;
END $$;

SELECT 'PASS keyset pagination practice proof' AS result;
