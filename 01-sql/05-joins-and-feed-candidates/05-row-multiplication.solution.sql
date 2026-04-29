-- Joining likes and comments directly multiplies rows when a post has many of both.
CREATE VIEW row_multiplication_bad AS SELECT p.id, l.user_id, c.id AS comment_id FROM posts p LEFT JOIN likes l ON l.post_id=p.id LEFT JOIN comments c ON c.post_id=p.id WHERE p.id=1;
CREATE VIEW row_multiplication_fixed AS SELECT p.id, (SELECT count(*) FROM likes l WHERE l.post_id=p.id) AS like_count, (SELECT count(*) FROM comments c WHERE c.post_id=p.id) AS comment_count FROM posts p WHERE p.id=1;
