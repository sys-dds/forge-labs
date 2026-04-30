CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

SELECT CASE WHEN NOT EXISTS (
  SELECT 1
  FROM information_schema.columns
  WHERE table_schema = 'public'
    AND table_name = 'ada_creator_discovery_page_one'
    AND column_name IN ('email', 'is_searchable')
) THEN 1 ELSE fail_test('Endpoint exposes private/raw fields') END AS shaped_projection_only;

CREATE TEMP TABLE expected_page (
  position integer,
  handle text,
  follower_count bigint,
  mutual_follow_count bigint,
  recent_visible_post_count bigint
);

INSERT INTO expected_page VALUES
  (1, 'diya', 3, 1, 2),
  (2, 'lina', 2, 1, 1),
  (3, 'maya', 2, 1, 1);

CREATE TEMP TABLE actual_page AS
SELECT
  ROW_NUMBER() OVER (
    ORDER BY recent_visible_post_count DESC, follower_count DESC, cursor_created_at DESC, creator_id DESC
  )::integer AS position,
  handle,
  follower_count,
  mutual_follow_count,
  recent_visible_post_count
FROM ada_creator_discovery_page_one;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_page EXCEPT SELECT * FROM actual_page)
  UNION ALL
  (SELECT * FROM actual_page EXCEPT SELECT * FROM expected_page)
) THEN 1 ELSE fail_test('Creator discovery page is not exact') END AS exact_page_order_and_counts;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'ben') THEN 1 ELSE fail_test('Ben already followed returned') END AS ben_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'cy') THEN 1 ELSE fail_test('Cy blocked returned') END AS cy_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'noor') THEN 1 ELSE fail_test('Noor private returned') END AS noor_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'omar') THEN 1 ELSE fail_test('Omar no visible signal returned') END AS omar_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'theo') THEN 1 ELSE fail_test('Theo disconnected returned') END AS theo_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_creator_discovery_page_one WHERE handle = 'ada') THEN 1 ELSE fail_test('Ada returned in own discovery') END AS ada_excluded;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM ada_creator_discovery_page_one
  WHERE handle = 'diya' AND follower_count = 3 AND mutual_follow_count = 1 AND recent_visible_post_count = 2
) THEN 1 ELSE fail_test('expected Diya counts follower_count=3 mutual_follow_count=1 recent_visible_post_count=2; broken endpoint multiplied posts and followers') END AS diya_counts;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM ada_creator_discovery_page_one
  WHERE handle = 'lina' AND follower_count = 2 AND mutual_follow_count = 1 AND recent_visible_post_count = 1
) THEN 1 ELSE fail_test('expected Lina counts follower_count=2 mutual_follow_count=1 recent_visible_post_count=1; broken endpoint missed Lina tie row') END AS lina_counts;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM ada_creator_discovery_page_one
  WHERE handle = 'maya' AND follower_count = 2 AND mutual_follow_count = 1 AND recent_visible_post_count = 1
) THEN 1 ELSE fail_test('expected Maya counts follower_count=2 mutual_follow_count=1 recent_visible_post_count=1; broken endpoint missed Maya tie row') END AS maya_counts;

SELECT CASE WHEN (
  SELECT string_agg(handle, ',' ORDER BY recent_visible_post_count DESC, follower_count DESC, cursor_created_at DESC, creator_id DESC)
  FROM ada_creator_discovery_page_one
) = 'diya,lina,maya' THEN 1 ELSE fail_test('expected stable order diya,lina,maya; broken endpoint missed creator_id tie-breaker for Lina and Maya') END AS stable_ordering;
