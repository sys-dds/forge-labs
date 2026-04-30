CREATE VIEW ada_visible_social_posts AS
WITH eligible_posts AS (
  SELECT post_rows.id, post_rows.author_id, post_rows.visibility, 'followed_public' AS visible_reason
  FROM users viewer
  JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
  JOIN posts post_rows ON post_rows.author_id = follow_rows.followee_id
  WHERE viewer.handle = 'ada'
    AND post_rows.visibility = 'public'
    AND post_rows.is_hidden = false

  UNION ALL

  SELECT post_rows.id, post_rows.author_id, post_rows.visibility, 'followed_followers_only' AS visible_reason
  FROM users viewer
  JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
  JOIN posts post_rows ON post_rows.author_id = follow_rows.followee_id
  WHERE viewer.handle = 'ada'
    AND post_rows.visibility = 'followers'
    AND post_rows.is_hidden = false

  UNION ALL

  SELECT post_rows.id, post_rows.author_id, post_rows.visibility, 'shared_group' AS visible_reason
  FROM users viewer
  JOIN group_memberships viewer_membership ON viewer_membership.user_id = viewer.id
  JOIN posts post_rows ON post_rows.group_id = viewer_membership.group_id
  WHERE viewer.handle = 'ada'
    AND post_rows.visibility = 'group'
    AND post_rows.is_hidden = false
),
safe_posts AS (
  SELECT DISTINCT eligible_posts.*
  FROM users viewer
  JOIN eligible_posts ON true
  WHERE viewer.handle = 'ada'
    AND NOT EXISTS (SELECT 1 FROM mutes m WHERE m.muter_id = viewer.id AND m.muted_id = eligible_posts.author_id)
    AND NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id = viewer.id AND b.blocked_id = eligible_posts.author_id)
),
comment_counts AS (SELECT post_id, COUNT(*) AS comment_count FROM comments GROUP BY post_id),
reaction_counts AS (SELECT post_id, COUNT(*) AS reaction_count FROM reactions GROUP BY post_id),
repost_counts AS (SELECT post_id, COUNT(*) AS repost_count FROM reposts GROUP BY post_id)
SELECT
  safe_posts.id AS post_id,
  author.handle AS author_handle,
  safe_posts.visibility,
  safe_posts.visible_reason,
  COALESCE(comment_counts.comment_count, 0) AS comment_count,
  COALESCE(reaction_counts.reaction_count, 0) AS reaction_count,
  COALESCE(repost_counts.repost_count, 0) AS repost_count
FROM safe_posts
JOIN users author ON author.id = safe_posts.author_id
LEFT JOIN comment_counts ON comment_counts.post_id = safe_posts.id
LEFT JOIN reaction_counts ON reaction_counts.post_id = safe_posts.id
LEFT JOIN repost_counts ON repost_counts.post_id = safe_posts.id
ORDER BY safe_posts.id;

