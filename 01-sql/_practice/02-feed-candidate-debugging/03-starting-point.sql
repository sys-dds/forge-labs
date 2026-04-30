CREATE OR REPLACE VIEW ada_followed_posts_raw AS
SELECT
  posts.id AS post_id,
  authors.handle AS author_handle
FROM users AS ada
JOIN follows
  ON follows.follower_id = ada.id
JOIN users AS authors
  ON authors.id = follows.followee_id
JOIN posts
  ON posts.author_id = authors.id
WHERE ada.handle = 'ada';

CREATE OR REPLACE VIEW ada_feed_candidates AS
SELECT
  post_id,
  author_handle,
  0::integer AS like_count,
  0::integer AS comment_count
FROM ada_followed_posts_raw
WHERE false;
