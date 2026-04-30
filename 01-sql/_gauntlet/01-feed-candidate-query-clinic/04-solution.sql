CREATE OR REPLACE VIEW gauntlet_result AS
WITH like_counts AS (
  SELECT post_id, count(*)::integer AS like_count FROM likes GROUP BY post_id
),
comment_counts AS (
  SELECT post_id, count(*)::integer AS comment_count FROM comments GROUP BY post_id
)
SELECT
  posts.id AS post_id,
  authors.handle AS author_handle,
  coalesce(like_counts.like_count, 0) AS like_count,
  coalesce(comment_counts.comment_count, 0) AS comment_count
FROM users AS ada
JOIN follows ON follows.follower_id = ada.id
JOIN users AS authors ON authors.id = follows.followee_id
JOIN posts ON posts.author_id = authors.id
LEFT JOIN like_counts ON like_counts.post_id = posts.id
LEFT JOIN comment_counts ON comment_counts.post_id = posts.id
WHERE ada.handle = 'ada'
  AND NOT EXISTS (SELECT 1 FROM mutes WHERE muter_id = ada.id AND muted_id = authors.id)
  AND NOT EXISTS (SELECT 1 FROM blocks WHERE blocker_id = ada.id AND blocked_id = authors.id)
ORDER BY posts.id;
