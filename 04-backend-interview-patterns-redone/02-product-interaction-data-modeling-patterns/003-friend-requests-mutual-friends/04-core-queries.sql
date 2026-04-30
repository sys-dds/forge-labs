SET search_path TO bip_pim_003;

-- Read query: accepted friendships expanded both ways.
SELECT user_id_low AS user_id, user_id_high AS friend_id FROM friendships
UNION ALL
SELECT user_id_high, user_id_low FROM friendships
ORDER BY user_id, friend_id;

-- Debug query: request lifecycle rows that must not all become friendships.
SELECT request_id, requester_user_id, addressee_user_id, status
FROM friend_requests
ORDER BY request_id;

-- Mutual query: mutual friends between Ada and Ben.
WITH edges AS (
  SELECT user_id_low AS user_id, user_id_high AS friend_id FROM friendships
  UNION ALL SELECT user_id_high, user_id_low FROM friendships
)
SELECT u.display_name
FROM edges a
JOIN edges b ON b.friend_id=a.friend_id
JOIN users u ON u.user_id=a.friend_id
WHERE a.user_id=1 AND b.user_id=2
ORDER BY u.display_name;
