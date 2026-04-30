DO $$
DECLARE ids integer[];
BEGIN
  SELECT array_agg(post_id ORDER BY created_at DESC, post_id DESC) INTO ids FROM takehome_feed;
  IF ids IS DISTINCT FROM ARRAY[102,101]::integer[] THEN RAISE EXCEPTION 'feed ids should be {102,101}, got %', ids; END IF;
  IF NOT EXISTS (SELECT 1 FROM takehome_feed WHERE post_id=101 AND author_handle='ben' AND like_count=2 AND comment_count=3) THEN RAISE EXCEPTION 'post 101 counts wrong'; END IF;
  IF NOT EXISTS (SELECT 1 FROM takehome_feed WHERE post_id=102 AND like_count=1 AND comment_count=0) THEN RAISE EXCEPTION 'post 102 zero-comment row missing'; END IF;
END $$;
SELECT 'PASS social feed take-home' AS result;
