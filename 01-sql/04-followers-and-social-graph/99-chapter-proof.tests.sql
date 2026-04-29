DO $$
DECLARE c integer;
BEGIN
  SELECT count(*) INTO c FROM ada_followers WHERE handle IN ('grace','linus'); IF c <> 2 THEN RAISE EXCEPTION 'followers query wrong'; END IF;
  SELECT count(*) INTO c FROM ada_following WHERE handle IN ('grace','linus'); IF c <> 2 THEN RAISE EXCEPTION 'following query wrong'; END IF;
  SELECT count(*) INTO c FROM ada_mutual_follows WHERE handle IN ('grace','linus'); IF c <> 2 THEN RAISE EXCEPTION 'mutual follows wrong'; END IF;
  SELECT count(*) INTO c FROM ada_follow_suggestions WHERE handle='ada'; IF c <> 0 THEN RAISE EXCEPTION 'suggestions included self'; END IF;
  SELECT count(*) INTO c FROM ada_follow_suggestions WHERE handle IN ('grace','linus'); IF c <> 0 THEN RAISE EXCEPTION 'suggestions included already followed'; END IF;
  SELECT count(*) INTO c FROM ada_follow_suggestions WHERE handle='donald'; IF c <> 0 THEN RAISE EXCEPTION 'suggestions included blocked user'; END IF;
  SELECT count(*) INTO c FROM ada_feed_visible_following WHERE handle='linus'; IF c <> 0 THEN RAISE EXCEPTION 'muted user was not suppressed'; END IF;
END $$;
