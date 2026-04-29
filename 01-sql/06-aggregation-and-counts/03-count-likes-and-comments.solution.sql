CREATE VIEW post_engagement_counts AS
SELECT p.id AS post_id,
       count(DISTINCT l.user_id) AS like_count,
       count(DISTINCT c.id) FILTER (WHERE c.deleted = false) AS visible_comment_count
FROM posts p
LEFT JOIN likes l ON l.post_id = p.id
LEFT JOIN comments c ON c.post_id = p.id
WHERE p.visible
GROUP BY p.id ORDER BY p.id;
CREATE VIEW bad_join_count_for_a1 AS
SELECT p.id AS post_id, count(*) AS joined_rows
FROM posts p JOIN likes l ON l.post_id = p.id JOIN comments c ON c.post_id = p.id
WHERE p.id = 101 GROUP BY p.id;

