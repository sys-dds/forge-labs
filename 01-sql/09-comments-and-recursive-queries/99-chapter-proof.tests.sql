DO $$
DECLARE c integer; d integer;
BEGIN
  SELECT count(*) INTO c FROM direct_replies; IF c <> 2 THEN RAISE EXCEPTION 'direct replies wrong'; END IF;
  SELECT count(*) INTO c FROM recursive_thread; IF c <> 4 THEN RAISE EXCEPTION 'recursive thread should include all descendants'; END IF;
  SELECT depth INTO d FROM recursive_thread WHERE id=3; IF d <> 2 THEN RAISE EXCEPTION 'depth wrong'; END IF;
  SELECT count(*) INTO c FROM comment_depth_and_path WHERE path IS NULL; IF c <> 0 THEN RAISE EXCEPTION 'path missing'; END IF;
  BEGIN INSERT INTO comments (post_id,parent_comment_id,body) VALUES (1,999,'ghost'); RAISE EXCEPTION 'invalid parent should fail'; EXCEPTION WHEN foreign_key_violation THEN NULL; END;
END $$;
