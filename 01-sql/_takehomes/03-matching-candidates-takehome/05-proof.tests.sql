DO $$
DECLARE raw text[]; fit text[];
BEGIN
  SELECT array_agg(handle ORDER BY handle) INTO raw FROM raw_candidates;
  IF raw IS DISTINCT FROM ARRAY['maya','omar']::text[] THEN RAISE EXCEPTION 'raw candidates wrong: %', raw; END IF;
  SELECT array_agg(handle ORDER BY handle) INTO fit FROM preference_fit_candidates;
  IF fit IS DISTINCT FROM ARRAY['maya']::text[] THEN RAISE EXCEPTION 'fit candidates wrong: %', fit; END IF;
  IF NOT EXISTS (SELECT 1 FROM preference_fit_candidates WHERE handle='maya' AND shared_interest_count=2) THEN RAISE EXCEPTION 'Maya shared interests wrong'; END IF;
END $$;
SELECT 'PASS matching candidates take-home' AS result;
