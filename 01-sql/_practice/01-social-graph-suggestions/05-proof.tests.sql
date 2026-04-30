DO $$
DECLARE
  actual text[];
  path_count integer;
BEGIN
  SELECT array_agg(suggested_handle ORDER BY suggested_handle)
  INTO actual
  FROM ada_safe_suggestions;

  IF actual IS DISTINCT FROM ARRAY['diya']::text[] THEN
    RAISE EXCEPTION 'Ada safe suggestions mismatch: expected {diya}, got %', actual;
  END IF;

  IF EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE suggested_handle IN ('ben', 'cy')) THEN
    RAISE EXCEPTION 'Already-followed users Ben or Cy were suggested';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE suggested_handle = 'ada') THEN
    RAISE EXCEPTION 'Ada was suggested to herself';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE suggested_handle = 'noor') THEN
    RAISE EXCEPTION 'Blocked reachable user Noor was suggested';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE suggested_handle = 'theo') THEN
    RAISE EXCEPTION 'Disconnected Theo was suggested';
  END IF;

  SELECT count(*)
  INTO path_count
  FROM ada_second_degree_paths
  WHERE candidate_handle = 'diya';

  IF path_count <> 2 THEN
    RAISE EXCEPTION 'Expected two second-degree paths to Diya, got %', path_count;
  END IF;
END $$;

SELECT 'PASS social graph suggestions practice proof' AS result;
