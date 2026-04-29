DO $$
BEGIN
  BEGIN INSERT INTO users (handle, email) VALUES ('ada', 'new@forge.test'); RAISE EXCEPTION 'duplicate handle should fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO profiles (user_id, handle, display_name) VALUES (999, 'ghost', 'Ghost'); RAISE EXCEPTION 'invalid profile user should fail'; EXCEPTION WHEN foreign_key_violation THEN NULL; END;
  BEGIN INSERT INTO follows (follower_id, followee_id) VALUES (1, 2); RAISE EXCEPTION 'duplicate follow should fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO follows (follower_id, followee_id) VALUES (1, 1); RAISE EXCEPTION 'self follow should fail'; EXCEPTION WHEN check_violation THEN NULL; END;
  BEGIN INSERT INTO follows (follower_id, followee_id) VALUES (1, 999); RAISE EXCEPTION 'invalid follow user should fail'; EXCEPTION WHEN foreign_key_violation THEN NULL; END;
END $$;
