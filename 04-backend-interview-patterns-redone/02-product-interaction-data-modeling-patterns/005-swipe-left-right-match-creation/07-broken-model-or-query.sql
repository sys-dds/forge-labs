SET search_path TO bip_pim_005;
WITH right_swipes AS (SELECT DISTINCT LEAST(swiper_user_id,swiped_user_id) AS user_id_low, GREATEST(swiper_user_id,swiped_user_id) AS user_id_high FROM swipe_events WHERE direction='right'), candidates AS (SELECT display_name FROM users WHERE user_id<>1 AND active=true), checks AS (
  SELECT 'one_way_like_not_match' AS contract_name,'Ada-Ben' AS subject_id,COUNT(*)::text AS observed_value,'One-way right swipe is not necessarily an active match' AS expected_reason FROM right_swipes WHERE user_id_low=1 AND user_id_high=2
  UNION ALL SELECT 'mutual_like_match','Ada-Cy',COUNT(*)::text,'Mutual latest right swipes create one active match' FROM right_swipes WHERE user_id_low=1 AND user_id_high=3
  UNION ALL SELECT 'left_swipe_no_match','Ada-Diya',COUNT(*)::text,'Left swipe does not create match' FROM right_swipes WHERE user_id_low=1 AND user_id_high=4
  UNION ALL SELECT 'block_suppresses_match','Ada-Omar',COUNT(*)::text,'Block suppresses otherwise reciprocal swipe' FROM right_swipes WHERE user_id_low=1 AND user_id_high=5
  UNION ALL SELECT 'report_suppresses_match','Ada-Noor',COUNT(*)::text,'Report suppresses otherwise reciprocal swipe' FROM right_swipes WHERE user_id_low=1 AND user_id_high=6
  UNION ALL SELECT 'duplicate_match_prevented','Ada-Cy',COUNT(*)::text,'Canonical match pair prevents duplicates' FROM right_swipes WHERE user_id_low=1 AND user_id_high=3
  UNION ALL SELECT 'unmatched_not_active','Ada-Lina',COUNT(*)::text,'Unmatched pair is not active' FROM right_swipes WHERE user_id_low=1 AND user_id_high=7
  UNION ALL SELECT 'candidate_pool','Ada',COALESCE(string_agg(display_name,'|' ORDER BY display_name),'none'),'Candidate pool excludes blocked reported matched left-swiped and inactive rows' FROM candidates
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
