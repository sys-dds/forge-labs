CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer LANGUAGE plpgsql AS $$
BEGIN RAISE EXCEPTION '%', message; END;
$$;

CREATE TEMP TABLE expected_posts (post_id integer, author_handle text, visible_reason text);
INSERT INTO expected_posts VALUES
  (101, 'ben', 'followed_public'),
  (102, 'ben', 'followed_followers_only'),
  (401, 'diya', 'shared_group');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_posts EXCEPT SELECT post_id, author_handle, visible_reason FROM ada_visible_social_posts)
  UNION ALL
  (SELECT post_id, author_handle, visible_reason FROM ada_visible_social_posts EXCEPT SELECT * FROM expected_posts)
) THEN 1 ELSE fail_test('expected Ada visible social posts {101,102,401}; broken query leaked muted Cy 201, blocked Noor 301, public Omar 501, wrong-group Lina 601, hidden Ben 103, or missed valid posts') END AS exact_visible_posts;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM ada_visible_social_posts
  WHERE post_id = 101 AND comment_count = 2 AND reaction_count = 2 AND repost_count = 1
) THEN 1 ELSE fail_test('expected Ben post 101 counts comments=2 reactions=2 reposts=1; broken child joins duplicated or dropped child facts') END AS ben_101_counts_exact;

SELECT CASE WHEN (SELECT COUNT(*) FROM ada_visible_social_posts WHERE post_id = 101) = 1
  THEN 1 ELSE fail_test('expected Ben post 101 once; broken query duplicated it through comments/reactions/reposts') END AS ben_101_not_duplicated;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_visible_social_posts WHERE post_id IN (201, 301, 501, 601, 103))
  THEN 1 ELSE fail_test('expected posts 201,301,501,601,103 excluded by mute/block/no-path/wrong-group/hidden rules') END AS excluded_posts_absent;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_visible_social_posts WHERE post_id = 101)
  THEN 1 ELSE fail_test('expected Ben post 101 to survive even though Cy liked it and Noor commented on it') END AS child_actor_activity_does_not_remove_parent;

