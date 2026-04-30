CREATE OR REPLACE VIEW takehome_feed AS
WITH like_counts AS (SELECT post_id, count(*)::integer AS like_count FROM likes GROUP BY post_id),
comment_counts AS (SELECT post_id, count(*)::integer AS comment_count FROM comments GROUP BY post_id)
SELECT p.id AS post_id, author.handle AS author_handle, author.display_name,
  coalesce(like_counts.like_count,0) AS like_count,
  coalesce(comment_counts.comment_count,0) AS comment_count,
  p.created_at
FROM users viewer
JOIN follows f ON f.follower_id=viewer.id
JOIN users author ON author.id=f.followee_id
JOIN posts p ON p.author_id=author.id
LEFT JOIN like_counts ON like_counts.post_id=p.id
LEFT JOIN comment_counts ON comment_counts.post_id=p.id
WHERE viewer.handle='ada' AND NOT p.hidden
  AND NOT EXISTS (SELECT 1 FROM mutes WHERE muter_id=viewer.id AND muted_id=author.id)
  AND NOT EXISTS (SELECT 1 FROM blocks WHERE blocker_id=viewer.id AND blocked_id=author.id)
ORDER BY p.created_at DESC, p.id DESC;
