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
    AND table_name = 'ben_public_profile_card'
    AND column_name = 'email'
) THEN 1 ELSE fail_test('Ben public card exposes email') END AS no_email_column;

SELECT CASE WHEN EXISTS (
  SELECT 1 FROM ben_public_profile_card
  WHERE handle = 'ben'
    AND visible_post_count = 2
    AND follower_count = 2
    AND following_count = 1
) THEN 1 ELSE fail_test('expected Ben profile counts visible_post_count=2 follower_count=2 following_count=1; broken query multiplied Ben posts and followers') END AS ben_exact_counts;

SELECT CASE WHEN NOT EXISTS (
  SELECT 1 FROM ben_public_profile_card WHERE visible_post_count <> 2
) THEN 1 ELSE fail_test('Ben hidden post changed visible count') END AS hidden_post_excluded;

CREATE TEMP TABLE expected_search (handle text);
INSERT INTO expected_search VALUES ('ben'), ('diya');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_search EXCEPT SELECT handle FROM ada_safe_profile_search)
  UNION ALL
  (SELECT handle FROM ada_safe_profile_search EXCEPT SELECT * FROM expected_search)
) THEN 1 ELSE fail_test('expected Ada safe search handles {ben,diya}; broken query returned Ada, Cy, Noor, or Maya') END AS ada_safe_search_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_profile_search WHERE handle = 'cy') THEN 1 ELSE fail_test('Cy private profile returned') END AS cy_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_profile_search WHERE handle = 'noor') THEN 1 ELSE fail_test('Noor blocked profile returned') END AS noor_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_profile_search WHERE handle = 'ada') THEN 1 ELSE fail_test('Ada returned in own discovery') END AS ada_excluded;
SELECT CASE WHEN EXISTS (SELECT 1 FROM ada_safe_profile_search WHERE handle = 'diya') THEN 1 ELSE fail_test('Diya zero-post profile missing') END AS diya_included;
