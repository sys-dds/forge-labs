SET search_path TO bip_pim_003;
WITH edges AS (
  SELECT user_id_low AS user_id, user_id_high AS friend_id FROM friendships
  UNION ALL SELECT user_id_high, user_id_low FROM friendships
), ada_friends AS (SELECT friend_id FROM edges WHERE user_id=1), ben_friends AS (SELECT friend_id FROM edges WHERE user_id=2), mutuals AS (SELECT u.display_name FROM ada_friends a JOIN ben_friends b ON b.friend_id=a.friend_id JOIN users u ON u.user_id=a.friend_id ORDER BY u.display_name), checks AS (
  SELECT 'pending_not_friend' AS contract_name, 'Ada-Cy' AS subject_id, COUNT(*)::text AS observed_value, 'Pending request is not accepted friendship' AS expected_reason FROM edges WHERE user_id=1 AND friend_id=3
  UNION ALL SELECT 'accepted_visible_both_ways','Ada-Ben',COUNT(*)::text,'Accepted friendship reads both directions' FROM edges WHERE (user_id=1 AND friend_id=2) OR (user_id=2 AND friend_id=1)
  UNION ALL SELECT 'declined_not_friend','Ada-Diya',COUNT(*)::text,'Declined or cancelled request is not friendship' FROM edges WHERE (user_id=1 AND friend_id=4) OR (user_id=4 AND friend_id=1)
  UNION ALL SELECT 'block_prevents_friendship','Ada-Omar',COUNT(*)::text,'Ada block prevents Omar friendship visibility' FROM edges e LEFT JOIN block_edges b ON b.blocker_user_id=1 AND b.blocked_user_id=5 WHERE e.user_id=1 AND e.friend_id=5 AND b.blocker_user_id IS NULL
  UNION ALL SELECT 'mutual_friend_count','Ada-Ben',COUNT(*)::text,'Ada and Ben share accepted mutual friends' FROM mutuals
  UNION ALL SELECT 'mutual_friend_list','Ada-Ben',COALESCE(string_agg(display_name,'|' ORDER BY display_name),'none'),'Mutual friend list is deterministic' FROM mutuals
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
