CREATE OR REPLACE VIEW ada_second_degree_paths AS
SELECT
  first_degree.handle AS via_handle,
  candidate.handle AS candidate_handle
FROM users AS ada
JOIN follows AS ada_follows
  ON ada_follows.follower_id = ada.id
JOIN users AS first_degree
  ON first_degree.id = ada_follows.followee_id
JOIN follows AS second_hop
  ON second_hop.follower_id = first_degree.id
JOIN users AS candidate
  ON candidate.id = second_hop.followee_id
WHERE ada.handle = 'ada';

CREATE OR REPLACE VIEW ada_safe_suggestions AS
SELECT candidate_handle AS suggested_handle
FROM ada_second_degree_paths
WHERE false;
