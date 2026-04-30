CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

DO $$
BEGIN
  BEGIN
    INSERT INTO swipes (swiper_id, swiped_id, decision) VALUES (1, 2, 'PASS');
    RAISE EXCEPTION 'duplicate Ada swipe on Ben was accepted';
  EXCEPTION WHEN unique_violation THEN NULL;
  END;

  BEGIN
    INSERT INTO swipes (swiper_id, swiped_id, decision) VALUES (1, 1, 'LIKE');
    RAISE EXCEPTION 'Ada self-swipe was accepted';
  EXCEPTION WHEN check_violation THEN NULL;
  END;
END $$;

CREATE TEMP TABLE expected_matches (handle text);
INSERT INTO expected_matches VALUES ('ben');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_matches EXCEPT SELECT handle FROM mutual_matches)
  UNION ALL
  (SELECT handle FROM mutual_matches EXCEPT SELECT * FROM expected_matches)
) THEN 1 ELSE fail_test('assertion failed') END AS mutual_matches_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM mutual_matches WHERE handle = 'cy') THEN 1 ELSE fail_test('assertion failed') END AS pass_does_not_create_cy_match;

CREATE TEMP TABLE expected_raw_candidates (handle text);
INSERT INTO expected_raw_candidates VALUES ('maya'), ('omar');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_raw_candidates EXCEPT SELECT handle FROM raw_candidates)
  UNION ALL
  (SELECT handle FROM raw_candidates EXCEPT SELECT * FROM expected_raw_candidates)
) THEN 1 ELSE fail_test('assertion failed') END AS raw_candidates_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM raw_candidates WHERE handle = 'ben') THEN 1 ELSE fail_test('assertion failed') END AS ben_match_not_candidate;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM raw_candidates WHERE handle = 'cy') THEN 1 ELSE fail_test('assertion failed') END AS cy_passed_not_candidate;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM raw_candidates WHERE handle = 'diya') THEN 1 ELSE fail_test('assertion failed') END AS diya_blocked_not_candidate;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM raw_candidates WHERE handle = 'noor') THEN 1 ELSE fail_test('assertion failed') END AS noor_inactive_not_candidate;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM raw_candidates WHERE handle = 'ada') THEN 1 ELSE fail_test('assertion failed') END AS ada_not_own_candidate;

CREATE TEMP TABLE expected_fit_candidates (handle text, shared_interest_count bigint);
INSERT INTO expected_fit_candidates VALUES ('maya', 2);

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_fit_candidates EXCEPT SELECT handle, shared_interest_count FROM preference_fit_candidates)
  UNION ALL
  (SELECT handle, shared_interest_count FROM preference_fit_candidates EXCEPT SELECT * FROM expected_fit_candidates)
) THEN 1 ELSE fail_test('assertion failed') END AS fit_candidates_exact;
