DO $$
DECLARE
  ids text;
  c integer;
BEGIN
  SELECT string_agg(id::text, ',' ORDER BY author_id) INTO ids FROM latest_post_per_user;
  IF ids <> '2,4' THEN RAISE EXCEPTION 'latest post ids wrong: %', ids; END IF;

  SELECT engagement_rank INTO c FROM ranked_posts WHERE id=2;
  IF c <> 1 THEN RAISE EXCEPTION 'top post should rank 1, got %', c; END IF;
  SELECT count(*) INTO c FROM ranked_posts WHERE id IN (3,4) AND engagement_rank=2;
  IF c <> 2 THEN RAISE EXCEPTION 'rank tie behavior for posts 3 and 4 is wrong'; END IF;

  SELECT count(*) INTO c FROM dense_ranked_authors WHERE handle IN ('grace','linus') AND follower_dense_rank=1;
  IF c <> 2 THEN RAISE EXCEPTION 'dense rank tie behavior wrong'; END IF;

  SELECT running_total INTO c FROM running_engagement_total WHERE id=2;
  IF c <> 5 THEN RAISE EXCEPTION 'running total wrong, got %', c; END IF;

  SELECT count(*) INTO c FROM information_schema.columns WHERE table_name='feed_ranking_inputs' AND column_name IN ('post_id','author_id','created_at','like_count','comment_count','follower_relationship_exists');
  IF c <> 6 THEN RAISE EXCEPTION 'ranking input columns missing'; END IF;
END $$;
