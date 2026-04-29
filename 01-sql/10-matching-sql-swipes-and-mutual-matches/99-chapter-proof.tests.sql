DO $$
DECLARE
  ok boolean := false;
  handles text[];
  shared integer;
BEGIN
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,2,'LIKE');
  EXCEPTION WHEN unique_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'duplicate swipe should fail'; END IF;

  ok := false;
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,1,'LIKE');
  EXCEPTION WHEN check_violation THEN ok := true; END;
  IF NOT ok THEN RAISE EXCEPTION 'self-swipe should fail'; END IF;

  SELECT array_agg(user_a_handle || '-' || user_b_handle ORDER BY user_b_handle) INTO handles FROM mutual_matches;
  IF handles <> ARRAY['ada-ben'] THEN RAISE EXCEPTION 'expected only ada-ben match got %', handles; END IF;

  IF EXISTS (SELECT 1 FROM mutual_matches WHERE user_b_handle = 'cy' OR user_a_handle = 'cy') THEN
    RAISE EXCEPTION 'PASS must not create Ada-Cy match';
  END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_raw_matching_candidates;
  IF handles <> ARRAY['maya','omar'] THEN RAISE EXCEPTION 'expected raw candidates maya,omar got %', handles; END IF;

  SELECT array_agg(handle ORDER BY handle) INTO handles FROM ada_preference_fit_candidates;
  IF handles <> ARRAY['maya'] THEN RAISE EXCEPTION 'expected preference-fit candidate maya got %', handles; END IF;

  SELECT shared_interest_count INTO shared FROM ada_preference_fit_candidates WHERE handle = 'maya';
  IF shared <> 2 THEN RAISE EXCEPTION 'expected Maya shared_interest_count 2 got %', shared; END IF;

  IF EXISTS (SELECT 1 FROM ada_raw_matching_candidates WHERE handle IN ('ada','ben','cy','diya','noor')) THEN
    RAISE EXCEPTION 'self, already-swiped, blocked, or inactive user reached raw candidates';
  END IF;
END $$;

