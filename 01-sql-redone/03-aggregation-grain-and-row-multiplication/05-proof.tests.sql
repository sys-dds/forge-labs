CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

SELECT CASE WHEN (
  SELECT COUNT(*)
  FROM posts p
  JOIN post_likes pl ON pl.post_id = p.id
  JOIN comments c ON c.post_id = p.id
  WHERE p.id = 'A1'
) = 6 THEN 1 ELSE fail_test('assertion failed') END AS a1_raw_join_has_six_rows;

CREATE TEMP TABLE expected_post_metrics (
  post_id text,
  author_handle text,
  like_count bigint,
  comment_count bigint
);

INSERT INTO expected_post_metrics VALUES
  ('A1', 'ada', 2, 3),
  ('A2', 'ada', 1, 0),
  ('B1', 'ben', 3, 1);

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_post_metrics EXCEPT SELECT post_id, author_handle, like_count, comment_count FROM post_metrics)
  UNION ALL
  (SELECT post_id, author_handle, like_count, comment_count FROM post_metrics EXCEPT SELECT * FROM expected_post_metrics)
) THEN 1 ELSE fail_test('assertion failed') END AS exact_post_metrics;

CREATE TEMP TABLE expected_author_metrics (
  author_handle text,
  visible_post_count bigint,
  total_likes bigint,
  total_comments bigint
);

INSERT INTO expected_author_metrics VALUES
  ('ada', 2, 3, 3),
  ('ben', 1, 3, 1),
  ('cy', 0, 0, 0);

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_author_metrics EXCEPT SELECT author_handle, visible_post_count, total_likes, total_comments FROM author_metrics)
  UNION ALL
  (SELECT author_handle, visible_post_count, total_likes, total_comments FROM author_metrics EXCEPT SELECT * FROM expected_author_metrics)
) THEN 1 ELSE fail_test('assertion failed') END AS exact_author_metrics;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM post_metrics WHERE post_id = 'A3') THEN 1 ELSE fail_test('assertion failed') END AS hidden_a3_excluded;
SELECT CASE WHEN EXISTS (SELECT 1 FROM post_metrics WHERE post_id = 'A2' AND comment_count = 0) THEN 1 ELSE fail_test('assertion failed') END AS a2_survives_zero_comments;
