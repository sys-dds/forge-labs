DO $$
DECLARE
  c integer;
  handles text;
BEGIN
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,2,'PASS'); RAISE EXCEPTION 'duplicate swipe should fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,1,'LIKE'); RAISE EXCEPTION 'self swipe should fail'; EXCEPTION WHEN check_violation THEN NULL; END;

  SELECT string_agg(user_a_id || '-' || user_b_id, ',' ORDER BY user_a_id, user_b_id) INTO handles FROM mutual_matches;
  IF handles <> '1-2' THEN RAISE EXCEPTION 'mutual match exact pair wrong: %', handles; END IF;

  SELECT count(*) INTO c FROM mutual_matches WHERE user_a_id=1 AND user_b_id=4;
  IF c <> 0 THEN RAISE EXCEPTION 'PASS created a match'; END IF;

  SELECT string_agg(handle, ',' ORDER BY handle) INTO handles FROM ada_match_candidates;
  IF handles <> 'barbara' THEN RAISE EXCEPTION 'candidate exact set wrong: %', handles; END IF;

  SELECT count(*) INTO c FROM ada_match_candidates WHERE id IN (2,3,4,5);
  IF c <> 0 THEN RAISE EXCEPTION 'blocked, inactive, or already-swiped user included'; END IF;

  SELECT string_agg(handle || ':' || shared_interest_count, ',' ORDER BY handle) INTO handles FROM ada_preference_fit;
  IF handles <> 'barbara:2' THEN RAISE EXCEPTION 'preference fit exact result wrong: %', handles; END IF;
END $$;
