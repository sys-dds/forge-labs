CREATE VIEW ada_feed_candidates AS
SELECT
  post_rows.id AS post_id,
  author.handle AS author_handle,
  'followed_author' AS candidate_reason,
  NULL::text AS source_actor_handle,
  post_rows.created_at
FROM users viewer
JOIN follows follow_rows ON follow_rows.follower_id = viewer.id
JOIN posts post_rows ON post_rows.author_id = follow_rows.followee_id
JOIN users author ON author.id = post_rows.author_id
WHERE viewer.handle = 'ada'
ORDER BY post_rows.created_at;

