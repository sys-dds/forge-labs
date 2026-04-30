CREATE VIEW ada_creator_discovery_page_one AS
WITH graph_candidates AS (
  SELECT DISTINCT candidate.id AS creator_id
  FROM users ada
  JOIN follows first_hop ON first_hop.follower_id = ada.id
  JOIN follows second_hop ON second_hop.follower_id = first_hop.followee_id
  JOIN users candidate ON candidate.id = second_hop.followee_id
  WHERE ada.handle = 'ada'
    AND candidate.id <> ada.id
    AND NOT EXISTS (
      SELECT 1 FROM follows already
      WHERE already.follower_id = ada.id AND already.followee_id = candidate.id
    )
    AND NOT EXISTS (
      SELECT 1 FROM blocks b
      WHERE b.blocker_id = ada.id AND b.blocked_id = candidate.id
    )
),
visible_post_counts AS (
  SELECT
    author_id AS creator_id,
    COUNT(*) AS recent_visible_post_count,
    MAX(created_at) AS cursor_created_at
  FROM posts
  WHERE is_hidden = false
  GROUP BY author_id
),
follower_counts AS (
  SELECT followee_id AS creator_id, COUNT(*) AS follower_count
  FROM follows
  GROUP BY followee_id
),
mutual_counts AS (
  SELECT candidate.id AS creator_id, COUNT(DISTINCT followed_by_ada.followee_id) AS mutual_follow_count
  FROM users ada
  JOIN follows followed_by_ada ON followed_by_ada.follower_id = ada.id
  JOIN follows first_hop_to_candidate ON first_hop_to_candidate.follower_id = followed_by_ada.followee_id
  JOIN users candidate ON candidate.id = first_hop_to_candidate.followee_id
  WHERE ada.handle = 'ada'
  GROUP BY candidate.id
)
SELECT
  candidate.id AS creator_id,
  candidate.handle,
  profile_rows.display_name,
  COALESCE(fc.follower_count, 0) AS follower_count,
  COALESCE(mc.mutual_follow_count, 0) AS mutual_follow_count,
  vpc.recent_visible_post_count,
  'followed by someone Ada follows' AS reason_label,
  vpc.cursor_created_at,
  candidate.id AS cursor_creator_id
FROM graph_candidates gc
JOIN users candidate ON candidate.id = gc.creator_id
JOIN profiles profile_rows ON profile_rows.user_id = candidate.id
JOIN visible_post_counts vpc ON vpc.creator_id = candidate.id
LEFT JOIN follower_counts fc ON fc.creator_id = candidate.id
LEFT JOIN mutual_counts mc ON mc.creator_id = candidate.id
WHERE profile_rows.is_searchable = true
ORDER BY
  vpc.recent_visible_post_count DESC,
  COALESCE(fc.follower_count, 0) DESC,
  vpc.cursor_created_at DESC,
  candidate.id DESC
LIMIT 10;

