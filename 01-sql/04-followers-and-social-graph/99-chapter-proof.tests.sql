DO $$
DECLARE
  actual text;
  c integer;
BEGIN
  SELECT string_agg(handle, ',' ORDER BY handle) INTO actual FROM ada_followers;
  IF actual <> 'grace,linus' THEN RAISE EXCEPTION 'followers exact set wrong: %', actual; END IF;

  SELECT string_agg(handle, ',' ORDER BY handle) INTO actual FROM ada_following;
  IF actual <> 'grace,linus' THEN RAISE EXCEPTION 'following exact set wrong: %', actual; END IF;

  SELECT string_agg(handle, ',' ORDER BY handle) INTO actual FROM ada_mutual_follows;
  IF actual <> 'grace,linus' THEN RAISE EXCEPTION 'mutual follows exact set wrong: %', actual; END IF;

  SELECT string_agg(handle, ',' ORDER BY handle) INTO actual FROM ada_follow_suggestions;
  IF actual <> 'margaret' THEN RAISE EXCEPTION 'suggestion exact set wrong: %', actual; END IF;

  SELECT count(*) INTO c FROM ada_follow_suggestions WHERE handle IN ('ada','grace','linus','donald');
  IF c <> 0 THEN RAISE EXCEPTION 'suggestions included self, already-followed, or blocked users'; END IF;

  SELECT count(*) INTO c FROM ada_feed_visible_following WHERE handle='linus';
  IF c <> 0 THEN RAISE EXCEPTION 'muted user was not suppressed from feed-style result'; END IF;

  SELECT count(*) INTO c FROM follows WHERE follower_id=1 AND followee_id=3;
  IF c <> 1 THEN RAISE EXCEPTION 'mute should not delete the follow relationship'; END IF;
END $$;
