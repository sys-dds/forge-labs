CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer LANGUAGE plpgsql AS $$
BEGIN RAISE EXCEPTION '%', message; END;
$$;

CREATE TEMP TABLE expected_candidates (
  post_id integer,
  author_handle text,
  candidate_reason text,
  source_actor_handle text
);

INSERT INTO expected_candidates VALUES
  (101, 'ben', 'followed_author', NULL),
  (301, 'maya', 'shared_group', NULL),
  (601, 'lina', 'liked_by_following', 'diya'),
  (602, 'lina', 'reposted_by_following', 'diya');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_candidates EXCEPT SELECT post_id, author_handle, candidate_reason, source_actor_handle FROM ada_feed_candidates)
  UNION ALL
  (SELECT post_id, author_handle, candidate_reason, source_actor_handle FROM ada_feed_candidates EXCEPT SELECT * FROM expected_candidates)
) THEN 1 ELSE fail_test('expected Ada feed candidates {101 followed_author,301 shared_group,601 liked_by_following Diya,602 reposted_by_following Diya}; broken query missed recall sources or leaked Cy/Noor') END AS exact_candidates;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id IN (201, 701, 801, 901))
  THEN 1 ELSE fail_test('expected Cy 201, Noor 701, Omar 801, Theo 901 excluded by mute/block/no candidate path') END AS excluded_candidates_absent;

SELECT CASE WHEN (SELECT COUNT(*) FROM ada_feed_candidates) = 4
  THEN 1 ELSE fail_test('expected exactly four Ada candidates with no duplicate candidate rows') END AS no_duplicate_candidates;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id = 601 AND source_actor_handle = 'diya')
  THEN 1 ELSE fail_test('expected Lina 601 source actor Diya from liked_by_following path') END AS lina_601_source_actor;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_feed_candidates WHERE post_id = 602 AND source_actor_handle = 'diya')
  THEN 1 ELSE fail_test('expected Lina 602 source actor Diya from reposted_by_following path') END AS lina_602_source_actor;

