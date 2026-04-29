DO $$
DECLARE c integer;
BEGIN
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,2,'PASS'); RAISE EXCEPTION 'duplicate swipe should fail'; EXCEPTION WHEN unique_violation THEN NULL; END;
  BEGIN INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,1,'LIKE'); RAISE EXCEPTION 'self swipe should fail'; EXCEPTION WHEN check_violation THEN NULL; END;
  SELECT count(*) INTO c FROM mutual_matches WHERE user_a_id=1 AND user_b_id=2; IF c <> 1 THEN RAISE EXCEPTION 'mutual LIKE should match'; END IF;
  SELECT count(*) INTO c FROM mutual_matches WHERE user_a_id=1 AND user_b_id=4; IF c <> 0 THEN RAISE EXCEPTION 'PASS created a match'; END IF;
  SELECT count(*) INTO c FROM ada_match_candidates WHERE id IN (2,4); IF c <> 0 THEN RAISE EXCEPTION 'already-swiped users included'; END IF;
  SELECT count(*) INTO c FROM ada_match_candidates WHERE id=3; IF c <> 0 THEN RAISE EXCEPTION 'blocked user included'; END IF;
  SELECT count(*) INTO c FROM ada_preference_fit WHERE handle='margaret'; IF c <> 0 THEN RAISE EXCEPTION 'already passed candidate should not fit'; END IF;
END $$;
