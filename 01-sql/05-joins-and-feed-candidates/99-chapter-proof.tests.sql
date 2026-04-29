DO $$
DECLARE
  ids integer[];
  handles text[];
  inflated integer;
  like_count integer;
  observed_comment_count integer;
BEGIN
  SELECT array_agg(post_id ORDER BY post_id) INTO ids FROM ada_feed_candidates;
  IF ids <> ARRAY[101,102] THEN RAISE EXCEPTION 'expected feed candidates 101,102 got %', ids; END IF;

  SELECT array_agg(author_handle ORDER BY author_handle) INTO handles FROM ada_feed_candidates;
  IF handles <> ARRAY['ben','ben'] THEN RAISE EXCEPTION 'expected only Ben posts got %', handles; END IF;

  IF EXISTS (SELECT 1 FROM ada_feed_candidates WHERE author_id IN (3,5,4)) THEN
    RAISE EXCEPTION 'muted, blocked, or not-followed author reached feed candidates';
  END IF;

  SELECT multiplied_rows INTO inflated FROM bad_row_multiplication WHERE post_id = 101;
  IF inflated <> 6 THEN RAISE EXCEPTION 'expected post 101 bad multiplication 6 got %', inflated; END IF;

  SELECT f.like_count, f.comment_count INTO like_count, observed_comment_count FROM fixed_engagement_counts f WHERE post_id = 101;
  IF like_count <> 2 OR observed_comment_count <> 3 THEN RAISE EXCEPTION 'expected post 101 fixed counts 2/3 got %/%', like_count, observed_comment_count; END IF;

  SELECT f.comment_count INTO observed_comment_count FROM fixed_engagement_counts f WHERE post_id = 102;
  IF observed_comment_count <> 0 THEN RAISE EXCEPTION 'zero-comment post 102 should remain with count 0'; END IF;
END $$;
