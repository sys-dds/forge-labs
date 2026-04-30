CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_page_one (position integer, id integer);
INSERT INTO expected_page_one VALUES (1, 107), (2, 106);

CREATE TEMP TABLE actual_page_one AS
SELECT ROW_NUMBER() OVER (ORDER BY created_at DESC, id DESC)::integer AS position, id
FROM page_one_before_insert;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_page_one EXCEPT SELECT * FROM actual_page_one)
  UNION ALL
  (SELECT * FROM actual_page_one EXCEPT SELECT * FROM expected_page_one)
) THEN 1 ELSE fail_test('expected page one before insert to be posts {107,106} in created_at DESC,id DESC order') END AS page_one_exact_ids;

CREATE TEMP TABLE expected_keyset_page_two (position integer, id integer);
INSERT INTO expected_keyset_page_two VALUES (1, 105), (2, 104);

CREATE TEMP TABLE actual_keyset_page_two AS
SELECT ROW_NUMBER() OVER (ORDER BY created_at DESC, id DESC)::integer AS position, id
FROM keyset_page_two_after_106;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_keyset_page_two EXCEPT SELECT * FROM actual_keyset_page_two)
  UNION ALL
  (SELECT * FROM actual_keyset_page_two EXCEPT SELECT * FROM expected_keyset_page_two)
) THEN 1 ELSE fail_test('expected keyset page two after cursor post 106 to be posts {105,104}; broken offset or cursor comparison returned a duplicate or skipped tied rows') END AS keyset_page_two_exact_ids;

CREATE TEMP TABLE expected_tie_order (position integer, id integer);
INSERT INTO expected_tie_order VALUES (1, 105), (2, 104);

CREATE TEMP TABLE actual_tie_order AS
SELECT ROW_NUMBER() OVER (ORDER BY created_at DESC, id DESC)::integer AS position, id
FROM duplicate_timestamp_order;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_tie_order EXCEPT SELECT * FROM actual_tie_order)
  UNION ALL
  (SELECT * FROM actual_tie_order EXCEPT SELECT * FROM expected_tie_order)
) THEN 1 ELSE fail_test('expected same-timestamp posts 105 and 104 ordered by id DESC so cursor ties are stable') END AS duplicate_timestamp_ordered_by_id;

SELECT CASE WHEN EXISTS (SELECT 1 FROM keyset_page_two_after_106 WHERE id = 106) THEN fail_test('expected post 106 absent from page two after cursor 106; broken offset pagination duplicated the last row from page one after post 108 arrived') ELSE 1 END AS offset_duplicate_106_not_allowed;

CREATE TEMP TABLE expected_after_105 (position integer, id integer);
INSERT INTO expected_after_105 VALUES (1, 104), (2, 103);

CREATE TEMP TABLE actual_after_105 AS
SELECT ROW_NUMBER() OVER (ORDER BY created_at DESC, id DESC)::integer AS position, id
FROM created_at_only_after_105;

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_after_105 EXCEPT SELECT * FROM actual_after_105)
  UNION ALL
  (SELECT * FROM actual_after_105 EXCEPT SELECT * FROM expected_after_105)
) THEN 1 ELSE fail_test('expected cursor after post 105 to return {104,103}; broken created_at-only cursor missed tied post 104') END AS created_at_alone_misses_tied_row;
