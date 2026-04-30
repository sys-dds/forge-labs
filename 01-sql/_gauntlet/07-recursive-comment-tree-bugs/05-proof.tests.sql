DO $$
DECLARE ids integer[]; depths integer[];
BEGIN
  SELECT array_agg(id ORDER BY path) INTO ids FROM gauntlet_result;
  IF ids IS DISTINCT FROM ARRAY[1,2,4,5,3]::integer[] THEN RAISE EXCEPTION 'post 100 tree order mismatch: %', ids; END IF;
  SELECT array_agg(depth ORDER BY path) INTO depths FROM gauntlet_result;
  IF depths IS DISTINCT FROM ARRAY[0,1,2,3,1]::integer[] THEN RAISE EXCEPTION 'depths mismatch: %', depths; END IF;
  IF EXISTS (SELECT 1 FROM gauntlet_result WHERE post_id=200) THEN RAISE EXCEPTION 'post 200 leaked into post 100 tree'; END IF;
END $$;
SELECT 'PASS recursive comment gauntlet' AS result;
