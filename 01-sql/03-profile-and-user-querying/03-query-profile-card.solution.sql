CREATE VIEW profile_card AS
SELECT u.handle, p.display_name, p.bio,
       (SELECT count(*) FROM posts post WHERE post.author_id = u.id) AS post_count,
       (SELECT count(*) FROM follows f WHERE f.followee_id = u.id) AS follower_count,
       (SELECT count(*) FROM follows f WHERE f.follower_id = u.id) AS following_count
FROM users u JOIN profiles p ON p.user_id = u.id
WHERE p.searchable;

