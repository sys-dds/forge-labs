DO $$
DECLARE p1 integer[]; p2 integer[]; off2 integer[]; cursor_id integer;
BEGIN
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO p1 FROM gauntlet_page_one;
  IF p1 IS DISTINCT FROM ARRAY[107,106]::integer[] THEN RAISE EXCEPTION 'page one should be {107,106}, got %', p1; END IF;
  SELECT array_agg(id ORDER BY created_at DESC, id DESC) INTO p2 FROM gauntlet_page_two;
  IF p2 IS DISTINCT FROM ARRAY[105,104]::integer[] THEN RAISE EXCEPTION 'keyset page two should be {105,104}, got %', p2; END IF;
  SELECT id INTO cursor_id FROM gauntlet_cursor;
  IF cursor_id <> 106 THEN RAISE EXCEPTION 'cursor must contain id 106 tie-breaker, got %', cursor_id; END IF;
  IF to_regclass('gauntlet_offset_page_two') IS NOT NULL THEN
    SELECT array_agg(id ORDER BY id DESC) INTO off2 FROM gauntlet_offset_page_two;
    IF off2 IS NOT DISTINCT FROM ARRAY[106,105]::integer[] THEN RAISE NOTICE 'offset demonstrates repeat as expected'; END IF;
  END IF;
END $$;
SELECT 'PASS pagination gauntlet' AS result;
