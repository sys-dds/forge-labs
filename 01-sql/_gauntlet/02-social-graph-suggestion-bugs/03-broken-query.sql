CREATE OR REPLACE VIEW gauntlet_result AS
SELECT candidate.handle AS suggested_handle
FROM users AS ada
JOIN follows AS first_hop ON first_hop.follower_id = ada.id
JOIN follows AS second_hop ON second_hop.follower_id = first_hop.followee_id
JOIN users AS candidate ON candidate.id = second_hop.followee_id
WHERE ada.handle = 'ada'
ORDER BY candidate.handle;
