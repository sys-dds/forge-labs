CREATE VIEW ada_feed_candidates AS
WITH raw_candidates AS (
  SELECT post_rows.id AS post_id, 'followed_author' AS candidate_reason, NULL::integer AS source_actor_id
  FROM users viewer
  JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
  JOIN posts post_rows ON post_rows.author_id = follow_rows.followee_id
  WHERE viewer.handle = 'ada'

  UNION ALL

  SELECT post_rows.id, 'shared_group', NULL::integer
  FROM users viewer
  JOIN group_memberships viewer_group ON viewer_group.user_id = viewer.id
  JOIN posts post_rows ON post_rows.group_id = viewer_group.group_id
  WHERE viewer.handle = 'ada'

  UNION ALL

  SELECT liked_posts.id, 'liked_by_following', like_rows.user_id
  FROM users viewer
  JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
  JOIN post_likes like_rows ON like_rows.user_id = follow_rows.followee_id
  JOIN posts liked_posts ON liked_posts.id = like_rows.post_id
  WHERE viewer.handle = 'ada'

  UNION ALL

  SELECT reposted_posts.id, 'reposted_by_following', repost_rows.user_id
  FROM users viewer
  JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
  JOIN reposts repost_rows ON repost_rows.user_id = follow_rows.followee_id
  JOIN posts reposted_posts ON reposted_posts.id = repost_rows.post_id
  WHERE viewer.handle = 'ada'
),
safe_candidates AS (
  SELECT DISTINCT ON (raw_candidates.post_id, raw_candidates.candidate_reason)
    raw_candidates.post_id,
    raw_candidates.candidate_reason,
    raw_candidates.source_actor_id
  FROM users viewer
  JOIN raw_candidates ON true
  JOIN posts post_rows ON post_rows.id = raw_candidates.post_id
  WHERE viewer.handle = 'ada'
    AND NOT EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = viewer.id AND m.muted_id = post_rows.author_id)
    AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = viewer.id AND b.blocked_id = post_rows.author_id)
  ORDER BY raw_candidates.post_id, raw_candidates.candidate_reason, raw_candidates.source_actor_id
)
SELECT
  safe_candidates.post_id,
  author.handle AS author_handle,
  safe_candidates.candidate_reason,
  source_actor.handle AS source_actor_handle,
  post_rows.created_at
FROM safe_candidates
JOIN posts post_rows ON post_rows.id = safe_candidates.post_id
JOIN users author ON author.id = post_rows.author_id
LEFT JOIN users source_actor ON source_actor.id = safe_candidates.source_actor_id
ORDER BY post_rows.created_at;
