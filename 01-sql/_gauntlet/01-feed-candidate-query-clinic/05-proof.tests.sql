DO $$
DECLARE ids integer[];
BEGIN
  SELECT array_agg(post_id ORDER BY post_id) INTO ids FROM gauntlet_result;
  IF ids IS DISTINCT FROM ARRAY[101,102]::integer[] THEN
    RAISE EXCEPTION 'expected Ben posts {101,102}, got %', ids;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE post_id=101 AND like_count=2 AND comment_count=3) THEN
    RAISE EXCEPTION 'post 101 counts should be 2 likes and 3 comments';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE post_id=102 AND like_count=1 AND comment_count=0) THEN
    RAISE EXCEPTION 'post 102 must survive with zero comments';
  END IF;
  IF EXISTS (SELECT 1 FROM gauntlet_result WHERE post_id IN (201,301,401)) THEN
    RAISE EXCEPTION 'muted, blocked, or unfollowed post leaked into candidates';
  END IF;
END $$;
SELECT 'PASS feed candidate gauntlet' AS result;
