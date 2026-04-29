DO $$
DECLARE v integer; handles text[];
BEGIN
  SELECT follower_count INTO v FROM follower_counts WHERE handle = 'ada'; IF v <> 2 THEN RAISE EXCEPTION 'Ada follower count expected 2 got %', v; END IF;
  SELECT visible_post_count INTO v FROM visible_post_counts WHERE handle = 'ada'; IF v <> 2 THEN RAISE EXCEPTION 'Ada visible posts expected 2 got %', v; END IF;
  SELECT visible_post_count INTO v FROM visible_post_counts WHERE handle = 'diya'; IF v <> 0 THEN RAISE EXCEPTION 'Diya hidden post should not count'; END IF;
  SELECT visible_comment_count INTO v FROM post_engagement_counts WHERE post_id = 101; IF v <> 2 THEN RAISE EXCEPTION 'deleted comment should be excluded from A1'; END IF;
  SELECT like_count INTO v FROM post_engagement_counts WHERE post_id = 201; IF v <> 3 THEN RAISE EXCEPTION 'Ben B1 likes expected 3'; END IF;
  SELECT joined_rows INTO v FROM bad_join_count_for_a1 WHERE post_id = 101; IF v <= 2 THEN RAISE EXCEPTION 'bad joined rows should prove inflation'; END IF;
  SELECT array_agg(handle ORDER BY handle) INTO handles FROM authors_with_more_than_one_visible_post;
  IF handles <> ARRAY['ada'] THEN RAISE EXCEPTION 'HAVING expected only ada got %', handles; END IF;
END $$;

