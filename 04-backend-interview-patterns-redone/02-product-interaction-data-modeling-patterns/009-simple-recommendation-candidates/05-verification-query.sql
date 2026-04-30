SET search_path TO bip_pim_009;
WITH source_rows AS (
  SELECT ff.followed_user_id AS candidate_user_id, 'mutual_follow' AS source_label FROM follow_edges mine JOIN follow_edges ff ON ff.follower_user_id=mine.followed_user_id AND ff.state='active' WHERE mine.follower_user_id=1 AND mine.state='active'
  UNION SELECT p.author_user_id, 'shared_interest' FROM user_interests mine JOIN posts p ON p.tag=mine.tag WHERE mine.user_id=1
  UNION SELECT swiped_user_id, 'swipe_signal' FROM swipe_events WHERE swiper_user_id=1 AND direction='right'
), eligible AS (
  SELECT sr.candidate_user_id, sr.source_label FROM source_rows sr JOIN users u ON u.user_id=sr.candidate_user_id AND u.status='active' JOIN creators c ON c.creator_user_id=sr.candidate_user_id AND c.discoverable LEFT JOIN follow_edges already ON already.follower_user_id=1 AND already.followed_user_id=sr.candidate_user_id AND already.state='active' LEFT JOIN matches m ON m.user_id_low=LEAST(1,sr.candidate_user_id) AND m.user_id_high=GREATEST(1,sr.candidate_user_id) AND m.unmatched_at IS NULL LEFT JOIN block_edges b1 ON b1.blocker_user_id=1 AND b1.blocked_user_id=sr.candidate_user_id LEFT JOIN block_edges b2 ON b2.blocker_user_id=sr.candidate_user_id AND b2.blocked_user_id=1 LEFT JOIN report_events r ON r.reporter_user_id=1 AND r.reported_user_id=sr.candidate_user_id WHERE sr.candidate_user_id<>1 AND already.follower_user_id IS NULL AND m.match_id IS NULL AND b1.blocker_user_id IS NULL AND b2.blocker_user_id IS NULL AND r.report_id IS NULL
), by_candidate AS (SELECT candidate_user_id, string_agg(source_label,'+' ORDER BY source_label) AS labels FROM eligible GROUP BY candidate_user_id), checks AS (
  SELECT 'mutual_follow_candidate' contract_name, 'user:3' subject_id, count(*)::text observed_value, 'Cy appears because Ada follows Ben and Ben follows Cy' expected_reason FROM eligible WHERE candidate_user_id=3 AND source_label='mutual_follow'
  UNION ALL SELECT 'shared_interest_candidate','user:4',count(*)::text,'Diya appears from Ada hiking interest and Diya hiking post' FROM eligible WHERE candidate_user_id=4 AND source_label='shared_interest'
  UNION ALL SELECT 'swipe_signal_candidate','user:5',count(*)::text,'Eli appears from Ada latest right swipe signal' FROM eligible WHERE candidate_user_id=5 AND source_label='swipe_signal'
  UNION ALL SELECT 'already_followed_excluded','user:6',count(*)::text,'Fay is already followed by Ada' FROM eligible WHERE candidate_user_id=6
  UNION ALL SELECT 'already_matched_excluded','user:7',count(*)::text,'Gus is already matched with Ada' FROM eligible WHERE candidate_user_id=7
  UNION ALL SELECT 'blocked_reported_excluded','users:8|9',count(*)::text,'Hana is blocked and Ivan is reported' FROM eligible WHERE candidate_user_id = 8 OR candidate_user_id = 9
  UNION ALL SELECT 'candidate_source_labels','viewer:1',COALESCE(string_agg(candidate_user_id::text||':'||labels,'|' ORDER BY candidate_user_id),'none'),'Candidate rows keep source labels before ranking' FROM by_candidate
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
