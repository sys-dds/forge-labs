DO $$
DECLARE c integer;
BEGIN
  BEGIN INSERT INTO user_profiles (user_id, display_name) VALUES (999, 'Ghost'); RAISE EXCEPTION 'expected invalid profile user to fail'; EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  BEGIN INSERT INTO user_profiles (user_id, display_name) VALUES (1, 'Duplicate Ada'); RAISE EXCEPTION 'expected duplicate profile to fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO posts (author_id, body) VALUES (999, 'orphan'); RAISE EXCEPTION 'expected orphan post to fail'; EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  SELECT count(*) INTO c FROM posts WHERE author_id = 1; IF c <> 2 THEN RAISE EXCEPTION 'expected Ada to have many posts, got %', c; END IF;
  SELECT count(*) INTO c FROM users u LEFT JOIN user_settings s ON s.user_id = u.id WHERE u.handle = 'linus' AND s.user_id IS NULL; IF c <> 1 THEN RAISE EXCEPTION 'expected settings to be optional'; END IF;
  BEGIN INSERT INTO user_settings (user_id) VALUES (1); RAISE EXCEPTION 'expected duplicate settings to fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO follows_preview (follower_id, followee_id) VALUES (1, 2); RAISE EXCEPTION 'expected duplicate follow to fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
END $$;
