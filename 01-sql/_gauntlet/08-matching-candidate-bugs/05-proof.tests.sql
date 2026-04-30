DO $$
DECLARE mutuals text[]; raw text[]; fit text[];
BEGIN
  SELECT array_agg(handle ORDER BY handle) INTO mutuals FROM gauntlet_mutual_matches;
  IF mutuals IS DISTINCT FROM ARRAY['ben']::text[] THEN RAISE EXCEPTION 'mutuals should be {ben}, got %', mutuals; END IF;
  SELECT array_agg(handle ORDER BY handle) INTO raw FROM gauntlet_raw_candidates;
  IF raw IS DISTINCT FROM ARRAY['maya','omar']::text[] THEN RAISE EXCEPTION 'raw candidates should be {maya,omar}, got %', raw; END IF;
  SELECT array_agg(handle ORDER BY handle) INTO fit FROM gauntlet_fit_candidates;
  IF fit IS DISTINCT FROM ARRAY['maya']::text[] THEN RAISE EXCEPTION 'fit candidates should be {maya}, got %', fit; END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_fit_candidates WHERE handle='maya' AND shared_interest_count=2) THEN RAISE EXCEPTION 'Maya should share two interests'; END IF;
END $$;
SELECT 'PASS matching gauntlet' AS result;
