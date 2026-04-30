CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_direct (comment_id text);
INSERT INTO expected_direct VALUES ('c2'), ('c3');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_direct EXCEPT SELECT comment_id FROM post_100_direct_replies_to_c1)
  UNION ALL
  (SELECT comment_id FROM post_100_direct_replies_to_c1 EXCEPT SELECT * FROM expected_direct)
) THEN 1 ELSE fail_test('expected direct replies to c1 {c2,c3}; broken query returned the wrong post or parent rows') END AS direct_replies_exact;

CREATE TEMP TABLE expected_thread (
  position integer,
  comment_id text,
  depth integer
);

INSERT INTO expected_thread VALUES
  (1, 'c1', 0),
  (2, 'c2', 1),
  (3, 'c4', 2),
  (4, 'c5', 3),
  (5, 'c3', 1);

CREATE TEMP TABLE actual_thread AS
SELECT ROW_NUMBER() OVER ()::integer AS position, comment_id, depth
FROM post_100_thread_from_c1;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_thread EXCEPT SELECT * FROM actual_thread)
  UNION ALL
  (SELECT * FROM actual_thread EXCEPT SELECT * FROM expected_thread)
) THEN 1 ELSE fail_test('expected c1 thread order/depth {c1:0,c2:1,c4:2,c5:3,c3:1}; broken recursion leaked c8/c6/c7 or kept depth at 0') END AS thread_order_and_depth_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM post_100_thread_from_c1 WHERE comment_id IN ('c6', 'c7')) THEN 1 ELSE fail_test('Post 200 comments leaked into post 100 thread') END AS post_200_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM post_100_thread_from_c1 WHERE comment_id = 'c8') THEN 1 ELSE fail_test('c8 root appeared in c1 subtree') END AS c8_excluded;

DO $$
BEGIN
  BEGIN
    INSERT INTO comments (id, post_id, parent_id, body, sort_order)
    VALUES ('bad-parent', 100, 'missing-comment', 'invalid parent', 99);
    RAISE EXCEPTION 'invalid parent was accepted';
  EXCEPTION WHEN foreign_key_violation THEN NULL;
  END;
END $$;
