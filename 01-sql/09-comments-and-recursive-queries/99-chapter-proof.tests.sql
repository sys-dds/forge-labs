DO $$
DECLARE ids integer[]; depths integer[]; bad_parent boolean := false;
BEGIN
  SELECT array_agg(id ORDER BY id) INTO ids FROM direct_replies_to_c1;
  IF ids <> ARRAY[2,3] THEN RAISE EXCEPTION 'expected direct replies 2,3 got %', ids; END IF;
  SELECT array_agg(id ORDER BY path) INTO ids FROM c1_recursive_thread;
  IF ids <> ARRAY[1,2,4,5,3] THEN RAISE EXCEPTION 'expected recursive order 1,2,4,5,3 got %', ids; END IF;
  SELECT array_agg(depth ORDER BY path) INTO depths FROM c1_recursive_thread;
  IF depths <> ARRAY[0,1,2,3,1] THEN RAISE EXCEPTION 'expected depths 0,1,2,3,1 got %', depths; END IF;
  IF EXISTS (SELECT 1 FROM c1_recursive_thread WHERE id IN (6,7)) THEN RAISE EXCEPTION 'post 200 comments leaked into post 100 thread'; END IF;
  BEGIN
    INSERT INTO comments VALUES (99,100,999,'invalid parent','2026-01-01 11:00+00');
  EXCEPTION WHEN foreign_key_violation THEN bad_parent := true;
  END;
  IF NOT bad_parent THEN RAISE EXCEPTION 'invalid parent comment should fail FK'; END IF;
END $$;

DO $$
DECLARE names text[];
BEGIN
  SELECT array_agg(name ORDER BY path) INTO names FROM electronics_category_tree;
  IF names <> ARRAY['Electronics','Computers','Laptops','Phones'] THEN
    RAISE EXCEPTION 'expected electronics category tree got %', names;
  END IF;
END $$;
