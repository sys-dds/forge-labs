CREATE OR REPLACE VIEW gauntlet_result AS
SELECT
  posts.id AS post_id,
  authors.handle AS author_handle,
  count(likes.user_id)::integer AS like_count,
  count(comments.id)::integer AS comment_count
FROM users AS ada
JOIN follows ON follows.follower_id = ada.id
JOIN users AS authors ON authors.id = follows.followee_id
JOIN posts ON posts.author_id = authors.id
JOIN likes ON likes.post_id = posts.id
JOIN comments ON comments.post_id = posts.id
WHERE ada.handle = 'ada'
GROUP BY posts.id, authors.handle
ORDER BY posts.id;
