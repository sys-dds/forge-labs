-- LEFT JOIN preserves posts even when optional metadata, such as comments, is missing.
CREATE VIEW left_join_comment_counts AS SELECT p.id, count(c.id) AS comment_count FROM posts p LEFT JOIN comments c ON c.post_id=p.id GROUP BY p.id ORDER BY p.id;
