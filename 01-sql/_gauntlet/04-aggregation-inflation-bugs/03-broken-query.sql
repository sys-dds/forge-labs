CREATE OR REPLACE VIEW gauntlet_result AS
SELECT u.handle, count(posts.id)::integer AS post_count, count(likes.user_id)::integer AS like_count, count(comments.id)::integer AS comment_count
FROM users u
LEFT JOIN posts ON posts.author_id=u.id
LEFT JOIN likes ON likes.post_id=posts.id
LEFT JOIN comments ON comments.post_id=posts.id
GROUP BY u.handle
HAVING count(posts.id) > 0
ORDER BY u.handle;
