DO $$
DECLARE
  ids text;
  d integer;
BEGIN
  SELECT string_agg(id::text, ',' ORDER BY id) INTO ids FROM direct_replies;
  IF ids <> '2,4' THEN RAISE EXCEPTION 'direct replies exact ids wrong: %', ids; END IF;

  SELECT string_agg(id::text, ',' ORDER BY path) INTO ids FROM recursive_thread;
  IF ids <> '1,2,3,4' THEN RAISE EXCEPTION 'recursive path order wrong: %', ids; END IF;

  SELECT depth INTO d FROM recursive_thread WHERE id=2;
  IF d <> 1 THEN RAISE EXCEPTION 'depth for direct reply wrong: %', d; END IF;
  SELECT depth INTO d FROM recursive_thread WHERE id=3;
  IF d <> 2 THEN RAISE EXCEPTION 'depth for nested reply wrong: %', d; END IF;

  BEGIN
    INSERT INTO comments (post_id,parent_comment_id,body) VALUES (1,999,'ghost');
    RAISE EXCEPTION 'invalid parent should fail';
  EXCEPTION WHEN foreign_key_violation THEN NULL;
  END;
END $$;
