CREATE VIEW ada_visible_social_posts AS
SELECT
  post_rows.id AS post_id,
  author.handle AS author_handle,
  post_rows.visibility,
  'public_or_group_table_scan' AS visible_reason,
  COUNT(comment_rows.id) AS comment_count,
  COUNT(reaction_rows.user_id) AS reaction_count,
  COUNT(repost_rows.user_id) AS repost_count
FROM users viewer
JOIN posts post_rows ON post_rows.visibility IN ('public', 'group')
JOIN users author ON author.id = post_rows.author_id
LEFT JOIN comments comment_rows ON comment_rows.post_id = post_rows.id
LEFT JOIN reactions reaction_rows ON reaction_rows.post_id = post_rows.id
LEFT JOIN reposts repost_rows ON repost_rows.post_id = post_rows.id
WHERE viewer.handle = 'ada'
GROUP BY post_rows.id, author.handle, post_rows.visibility
ORDER BY post_rows.id;

