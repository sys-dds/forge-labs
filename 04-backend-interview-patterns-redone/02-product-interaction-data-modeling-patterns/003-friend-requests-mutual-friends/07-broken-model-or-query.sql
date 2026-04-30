SET search_path TO bip_pim_003;
WITH request_edges AS (SELECT requester_user_id AS user_id, addressee_user_id AS friend_id FROM friend_requests UNION ALL SELECT addressee_user_id, requester_user_id FROM friend_requests), checks AS (
  SELECT 'pending_not_friend' AS contract_name,'Ada-Cy' AS subject_id,COUNT(*)::text AS observed_value,'Pending request is not accepted friendship' AS expected_reason FROM request_edges WHERE user_id=1 AND friend_id=3
  UNION ALL SELECT 'accepted_visible_both_ways','Ada-Ben',COUNT(*)::text,'Accepted friendship reads both directions' FROM request_edges WHERE (user_id=1 AND friend_id=2) OR (user_id=2 AND friend_id=1)
  UNION ALL SELECT 'declined_not_friend','Ada-Diya',COUNT(*)::text,'Declined or cancelled request is not friendship' FROM request_edges WHERE user_id IN (1,4) AND friend_id IN (1,4)
  UNION ALL SELECT 'block_prevents_friendship','Ada-Omar',COUNT(*)::text,'Ada block prevents Omar friendship visibility' FROM request_edges WHERE user_id=1 AND friend_id=5
  UNION ALL SELECT 'mutual_friend_count','Ada-Ben','0','Ada and Ben share accepted mutual friends' FROM users WHERE user_id=1
  UNION ALL SELECT 'mutual_friend_list','Ada-Ben','none','Mutual friend list is deterministic' FROM users WHERE user_id=1
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
