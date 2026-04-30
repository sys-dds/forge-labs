SET search_path TO bip_pim_005;
WITH latest_swipes AS (
  SELECT DISTINCT ON (swiper_user_id, swiped_user_id) swiper_user_id, swiped_user_id, direction FROM swipe_events ORDER BY swiper_user_id, swiped_user_id, created_at DESC, swipe_event_id DESC
), active_matches AS (SELECT * FROM matches WHERE unmatched_at IS NULL), pair_suppression AS (
  SELECT blocker_user_id AS a, blocked_user_id AS b FROM block_edges UNION ALL SELECT reported_user_id, reporter_user_id FROM report_events
), candidate_pool AS (
  SELECT u.user_id, u.display_name FROM users u JOIN user_profiles p ON p.user_id=u.user_id
  LEFT JOIN pair_suppression s1 ON s1.a=1 AND s1.b=u.user_id
  LEFT JOIN pair_suppression s2 ON s2.a=u.user_id AND s2.b=1
  LEFT JOIN matches m ON m.user_id_low=LEAST(1,u.user_id) AND m.user_id_high=GREATEST(1,u.user_id)
  LEFT JOIN latest_swipes ls ON ls.swiper_user_id=1 AND ls.swiped_user_id=u.user_id AND ls.direction='left'
  WHERE u.user_id<>1 AND u.active=true AND p.discoverable=true AND s1.a IS NULL AND s2.a IS NULL AND m.match_id IS NULL AND ls.swiper_user_id IS NULL
), checks AS (
  SELECT 'one_way_like_not_match' AS contract_name, 'Ada-Ben' AS subject_id, COUNT(*)::text AS observed_value, 'One-way right swipe is not necessarily an active match' AS expected_reason FROM active_matches WHERE user_id_low=1 AND user_id_high=2
  UNION ALL SELECT 'mutual_like_match','Ada-Cy',COUNT(*)::text,'Mutual latest right swipes create one active match' FROM active_matches WHERE user_id_low=1 AND user_id_high=3
  UNION ALL SELECT 'left_swipe_no_match','Ada-Diya',COUNT(*)::text,'Left swipe does not create match' FROM active_matches WHERE user_id_low=1 AND user_id_high=4
  UNION ALL SELECT 'block_suppresses_match','Ada-Omar',COUNT(*)::text,'Block suppresses otherwise reciprocal swipe' FROM active_matches WHERE user_id_low=1 AND user_id_high=5
  UNION ALL SELECT 'report_suppresses_match','Ada-Noor',COUNT(*)::text,'Report suppresses otherwise reciprocal swipe' FROM active_matches WHERE user_id_low=1 AND user_id_high=6
  UNION ALL SELECT 'duplicate_match_prevented','Ada-Cy',COUNT(*)::text,'Canonical match pair prevents duplicates' FROM matches WHERE user_id_low=1 AND user_id_high=3
  UNION ALL SELECT 'unmatched_not_active','Ada-Lina',COUNT(*)::text,'Unmatched pair is not active' FROM active_matches WHERE user_id_low=1 AND user_id_high=7
  UNION ALL SELECT 'candidate_pool','Ada',COALESCE(string_agg(display_name,'|' ORDER BY display_name),'none'),'Candidate pool excludes blocked reported matched left-swiped and inactive rows' FROM candidate_pool
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
