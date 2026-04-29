DO $$
DECLARE
  mutuals text[];
  raw_candidates text[];
  fit_candidates text[];
  duplicate_rejected boolean := false;
  self_rejected boolean := false;
BEGIN
  SELECT array_agg(matched_handle ORDER BY matched_handle)
  INTO mutuals
  FROM ada_mutual_matches;

  IF mutuals IS DISTINCT FROM ARRAY['ben']::text[] THEN
    RAISE EXCEPTION 'Ada mutual matches mismatch: expected {ben}, got %', mutuals;
  END IF;

  SELECT array_agg(candidate_handle ORDER BY candidate_handle)
  INTO raw_candidates
  FROM ada_raw_candidates;

  IF raw_candidates IS DISTINCT FROM ARRAY['maya', 'omar']::text[] THEN
    RAISE EXCEPTION 'Ada raw candidates mismatch: expected {maya,omar}, got %', raw_candidates;
  END IF;

  SELECT array_agg(candidate_handle ORDER BY candidate_handle)
  INTO fit_candidates
  FROM ada_preference_fit_candidates;

  IF fit_candidates IS DISTINCT FROM ARRAY['maya']::text[] THEN
    RAISE EXCEPTION 'Ada preference-fit candidates mismatch: expected {maya}, got %', fit_candidates;
  END IF;

  IF EXISTS (SELECT 1 FROM ada_mutual_matches WHERE matched_handle = 'cy') THEN
    RAISE EXCEPTION 'PASS created an Ada-Cy mutual match';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_raw_candidates WHERE candidate_handle IN ('ada', 'ben', 'cy', 'diya', 'noor')) THEN
    RAISE EXCEPTION 'Raw candidates include self, swiped, blocked, or inactive profile';
  END IF;

  IF EXISTS (SELECT 1 FROM ada_preference_fit_candidates WHERE candidate_handle = 'omar') THEN
    RAISE EXCEPTION 'Omar passed preference fit despite age 45 outside Ada max age 35';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM ada_preference_fit_candidates
    WHERE candidate_handle = 'maya'
      AND shared_interest_count = 2
  ) THEN
    RAISE EXCEPTION 'Maya should share exactly two interests with Ada';
  END IF;

  BEGIN
    INSERT INTO swipes (swiper_id, swiped_id, action) VALUES (1, 2, 'PASS');
  EXCEPTION WHEN unique_violation THEN
    duplicate_rejected := true;
  END;

  IF NOT duplicate_rejected THEN
    RAISE EXCEPTION 'Duplicate Ada->Ben swipe was not rejected';
  END IF;

  BEGIN
    INSERT INTO swipes (swiper_id, swiped_id, action) VALUES (1, 1, 'LIKE');
  EXCEPTION WHEN check_violation THEN
    self_rejected := true;
  END;

  IF NOT self_rejected THEN
    RAISE EXCEPTION 'Self-swipe was not rejected';
  END IF;
END $$;

SELECT 'PASS matching candidate filtering practice proof' AS result;
