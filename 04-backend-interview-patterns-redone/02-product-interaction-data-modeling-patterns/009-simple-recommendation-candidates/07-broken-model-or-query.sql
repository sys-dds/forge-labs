SET search_path TO bip_pim_009;
WITH popular_users AS (SELECT u.user_id AS candidate_user_id, 'popular' AS source_label FROM users u WHERE u.user_id<>1 AND u.status='active'), checks AS (
  SELECT 'mutual_follow_candidate' contract_name, 'user:3' subject_id, count(*)::text observed_value, 'Broken popularity ignores mutual source' expected_reason FROM popular_users WHERE candidate_user_id=3
  UNION ALL SELECT 'shared_interest_candidate','user:4',count(*)::text,'Broken popularity ignores shared interest source' FROM popular_users WHERE candidate_user_id=4
  UNION ALL SELECT 'swipe_signal_candidate','user:5',count(*)::text,'Broken popularity ignores swipe source' FROM popular_users WHERE candidate_user_id=5
  UNION ALL SELECT 'already_followed_excluded','user:6',count(*)::text,'Broken leaks already-followed users' FROM popular_users WHERE candidate_user_id=6
  UNION ALL SELECT 'already_matched_excluded','user:7',count(*)::text,'Broken leaks matched users' FROM popular_users WHERE candidate_user_id=7
  UNION ALL SELECT 'blocked_reported_excluded','users:8|9',count(*)::text,'Broken leaks blocked and reported users' FROM popular_users WHERE candidate_user_id IN (8,9)
  UNION ALL SELECT 'candidate_source_labels','viewer:1',COALESCE(string_agg(candidate_user_id::text||':'||source_label,'|' ORDER BY candidate_user_id),'none'),'Broken labels all rows popular' FROM popular_users
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
