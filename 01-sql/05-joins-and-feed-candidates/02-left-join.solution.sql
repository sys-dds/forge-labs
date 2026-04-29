-- LEFT JOIN keeps Ben post 102 even though it has zero comments.
CREATE VIEW left_join_comment_counts AS
SELECT p.id AS post_id, count(c.id) AS comment_count
FROM posts AS p
LEFT JOIN comments AS c ON c.post_id = p.id
GROUP BY p.id
ORDER BY p.id;

