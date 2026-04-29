DO $$
DECLARE c integer;
BEGIN
  SELECT follower_count INTO c FROM follower_counts WHERE user_id=1; IF c <> 2 THEN RAISE EXCEPTION 'follower count wrong'; END IF;
  SELECT like_count + comment_count INTO c FROM post_engagement_counts WHERE id=1; IF c <> 3 THEN RAISE EXCEPTION 'post engagement wrong'; END IF;
  SELECT likes INTO c FROM author_metrics WHERE handle='ada'; IF c <> 2 THEN RAISE EXCEPTION 'author metrics wrong'; END IF;
  SELECT count(*) INTO c FROM active_authors WHERE handle IN ('ada','grace'); IF c <> 2 THEN RAISE EXCEPTION 'having filter wrong'; END IF;
  SELECT count(*) INTO c FROM post_engagement_counts WHERE id=2; IF c <> 0 THEN RAISE EXCEPTION 'hidden row was included'; END IF;
END $$;
