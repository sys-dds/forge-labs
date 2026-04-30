DO $$
DECLARE
  actual_posts integer[];
  inflated_rows integer;
BEGIN
  SELECT array_agg(post_id ORDER BY post_id)
  INTO actual_posts
  FROM ada_feed_candidates;

  IF actual_posts IS DISTINCT FROM ARRAY[101, 102]::integer[] THEN
    RAISE EXCEPTION 'Ada feed candidates mismatch: expected {101,102}, got %', actual_posts;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM ada_feed_candidates
    WHERE post_id = 101 AND author_handle = 'ben' AND like_count = 2 AND comment_count = 3
  ) THEN
    RAISE EXCEPTION 'Post 101 did not keep exact Ben engagement counts 2 likes and 3 comments';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM ada_feed_candidates
    WHERE post_id = 102 AND author_handle = 'ben' AND like_count = 1 AND comment_count = 0
  ) THEN
    RAISE EXCEPTION 'Post 102 did not survive with one like and zero comments';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id = 201) THEN
    RAISE EXCEPTION 'Cy post 201 leaked despite Ada muting Cy';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id = 301) THEN
    RAISE EXCEPTION 'Noor post 301 leaked despite Ada blocking Noor';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id = 401) THEN
    RAISE EXCEPTION 'Diya post 401 leaked despite Ada not following Diya';
  END IF;

  SELECT count(*)
  INTO inflated_rows
  FROM posts
  JOIN post_likes ON post_likes.post_id = posts.id
  JOIN post_comments ON post_comments.post_id = posts.id
  WHERE posts.id = 101;

  IF inflated_rows <> 6 THEN
    RAISE EXCEPTION 'Direct likes/comments join should demonstrate 6 multiplied rows for post 101, got %', inflated_rows;
  END IF;
END $$;

SELECT 'PASS feed candidate debugging practice proof' AS result;
