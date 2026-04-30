CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_feed (
  position integer,
  post_id integer,
  author_handle text,
  like_count bigint,
  comment_count bigint
);

INSERT INTO expected_feed VALUES
  (1, 102, 'ben', 1, 0),
  (2, 101, 'ben', 2, 3);

CREATE TEMP TABLE actual_feed AS
SELECT
  ROW_NUMBER() OVER (ORDER BY created_at DESC, post_id DESC)::integer AS position,
  post_id,
  author_handle,
  like_count,
  comment_count
FROM ada_feed;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_feed EXCEPT SELECT * FROM actual_feed)
  UNION ALL
  (SELECT * FROM actual_feed EXCEPT SELECT * FROM expected_feed)
) THEN 1 ELSE fail_test('expected Ada feed rows exactly {102 first, 101 second}; broken query leaked Cy 201, Noor 301, Diya 401, Ben 103, duplicated Ben 101, or dropped zero-comment Ben 102') END AS exact_feed_rows;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 201) THEN 1 ELSE fail_test('expected Cy post 201 excluded because Ada muted Cy before ranking') END AS cy_muted_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 301) THEN 1 ELSE fail_test('expected Noor post 301 excluded because Ada blocked Noor before ranking') END AS noor_blocked_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 401) THEN 1 ELSE fail_test('expected Diya post 401 excluded because Ada does not follow Diya') END AS diya_unfollowed_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 103) THEN 1 ELSE fail_test('expected hidden Ben post 103 excluded even though Ada follows Ben') END AS hidden_ben_excluded;
SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 101 AND like_count = 2 AND comment_count = 3) THEN 1 ELSE fail_test('expected Ben post 101 counts like_count=2 and comment_count=3; broken joins inflated or lost child counts') END AS ben_101_counts;
SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_feed WHERE post_id = 102 AND like_count = 1 AND comment_count = 0) THEN 1 ELSE fail_test('expected Ben post 102 retained with like_count=1 and comment_count=0; broken inner comment join removed zero-comment post') END AS ben_102_counts;
