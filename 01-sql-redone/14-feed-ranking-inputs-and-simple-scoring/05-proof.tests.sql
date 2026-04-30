CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer LANGUAGE plpgsql AS $$
BEGIN RAISE EXCEPTION '%', message; END;
$$;

CREATE TEMP TABLE expected_scores (
  post_id integer,
  author_handle text,
  candidate_reason text,
  like_count integer,
  comment_count integer,
  recency_bucket text,
  author_affinity_score integer,
  engagement_score integer,
  recency_score integer,
  raw_score integer,
  diversity_group text,
  rank_position bigint
);

INSERT INTO expected_scores VALUES
  (101, 'ben', 'followed_author', 2, 3, 'recent', 10, 16, 5, 31, 'repeated_author:ben', 1),
  (102, 'ben', 'followed_author', 5, 1, 'older', 10, 14, 1, 25, 'repeated_author:ben', 2),
  (301, 'maya', 'shared_group', 1, 2, 'recent', 6, 10, 5, 21, 'single_author:maya', 3),
  (601, 'lina', 'liked_by_following', 4, 0, 'recent', 3, 8, 5, 16, 'repeated_author:lina', 4),
  (602, 'lina', 'reposted_by_following', 1, 1, 'older', 4, 6, 1, 11, 'repeated_author:lina', 5);

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_scores EXCEPT SELECT * FROM ada_ranked_feed_inputs)
  UNION ALL
  (SELECT * FROM ada_ranked_feed_inputs EXCEPT SELECT * FROM expected_scores)
) THEN 1 ELSE fail_test('expected ranked feed inputs with exact scores {101=31,102=25,301=21,601=16,602=11}; broken likes-only query ranks Ben 102 first or hides feature columns') END AS exact_scores_and_rank;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_ranked_feed_inputs WHERE post_id = 101 AND engagement_score = 16)
  THEN 1 ELSE fail_test('expected Ben 101 engagement_score 16 from 2 likes and 3 comments; broken query ignored comment weight') END AS comments_weighted_for_ben_101;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_ranked_feed_inputs WHERE post_id = 301 AND author_affinity_score = 6)
  THEN 1 ELSE fail_test('expected Maya 301 shared_group affinity score 6; broken query ignored candidate source') END AS maya_shared_group_bonus;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_ranked_feed_inputs WHERE post_id = 601 AND author_affinity_score = 3)
  THEN 1 ELSE fail_test('expected Lina 601 liked_by_following affinity score 3; broken query treated engagement as everything') END AS lina_lower_affinity;

SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_ranked_feed_inputs WHERE post_id = 102 AND diversity_group = 'repeated_author:ben')
  THEN 1 ELSE fail_test('expected Ben 102 diversity_group repeated_author:ben; broken query hid repeated-author information') END AS ben_repeated_author_group;

