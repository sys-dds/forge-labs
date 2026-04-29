DO $$
DECLARE ids integer[]; ranks integer[]; dense integer[]; totals integer[]; cols integer;
BEGIN
  SELECT array_agg(post_id ORDER BY author_id) INTO ids FROM latest_post_per_user;
  IF ids <> ARRAY[103,202,301] THEN RAISE EXCEPTION 'latest posts expected 103,202,301 got %', ids; END IF;
  SELECT array_agg(engagement_rank ORDER BY post_id) INTO ranks FROM ranked_posts WHERE post_id IN (103,202,101);
  IF ranks <> ARRAY[3,1,1] THEN RAISE EXCEPTION 'RANK tie/gap expected post 101 rank 3, 103/202 rank 1 got %', ranks; END IF;
  SELECT array_agg(follower_dense_rank ORDER BY handle) INTO dense FROM dense_ranked_authors;
  IF dense <> ARRAY[1,1,2] THEN RAISE EXCEPTION 'dense ranks expected ada/ben 1 cy 2 got %', dense; END IF;
  SELECT array_agg(running_total ORDER BY event_id) INTO totals FROM running_engagement_total WHERE author_id = 1;
  IF totals <> ARRAY[1,2,3] THEN RAISE EXCEPTION 'Ada running totals expected 1,2,3 got %', totals; END IF;
  SELECT count(*) INTO cols FROM information_schema.columns WHERE table_name='feed_ranking_inputs' AND column_name IN ('post_id','author_id','created_at','like_count','comment_count','follows_author','raw_score_input');
  IF cols <> 7 THEN RAISE EXCEPTION 'ranking input query missing expected columns'; END IF;
END $$;

