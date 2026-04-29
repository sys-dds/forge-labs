DO $$
DECLARE ok boolean; post_count integer; settings_count integer;
BEGIN
  ok := false; BEGIN INSERT INTO user_profiles VALUES (1,'Duplicate Ada','bad'); EXCEPTION WHEN unique_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'duplicate profile should fail'; END IF;
  ok := false; BEGIN INSERT INTO posts (author_id,body) VALUES (999,'orphan'); EXCEPTION WHEN foreign_key_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'post without user should fail'; END IF;
  SELECT count(*) INTO post_count FROM posts WHERE author_id = 1;
  IF post_count <> 2 THEN RAISE EXCEPTION 'Ada should have two posts got %', post_count; END IF;
  SELECT count(*) INTO settings_count FROM user_settings WHERE user_id = 2;
  IF settings_count <> 0 THEN RAISE EXCEPTION 'Ben should exist without settings'; END IF;
  ok := false; BEGIN INSERT INTO user_settings VALUES (1,false,false); EXCEPTION WHEN unique_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'duplicate settings should fail'; END IF;
  ok := false; BEGIN INSERT INTO follows_preview VALUES (1,2); EXCEPTION WHEN unique_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'duplicate follow preview should fail'; END IF;
END $$;

