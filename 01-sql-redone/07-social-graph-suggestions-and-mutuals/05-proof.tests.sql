CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_following (handle text);
INSERT INTO expected_following VALUES ('ben'), ('cy'), ('maya');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_following EXCEPT SELECT handle FROM ada_following)
  UNION ALL
  (SELECT handle FROM ada_following EXCEPT SELECT * FROM expected_following)
) THEN 1 ELSE fail_test('Ada following set is wrong') END AS following_exact;

CREATE TEMP TABLE expected_followers (handle text);
INSERT INTO expected_followers VALUES ('ben'), ('noor'), ('omar');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_followers EXCEPT SELECT handle FROM ada_followers)
  UNION ALL
  (SELECT handle FROM ada_followers EXCEPT SELECT * FROM expected_followers)
) THEN 1 ELSE fail_test('Ada followers set is wrong') END AS followers_exact;

CREATE TEMP TABLE expected_mutuals (handle text);
INSERT INTO expected_mutuals VALUES ('ben');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_mutuals EXCEPT SELECT handle FROM ada_mutual_follows)
  UNION ALL
  (SELECT handle FROM ada_mutual_follows EXCEPT SELECT * FROM expected_mutuals)
) THEN 1 ELSE fail_test('Ada mutual follows set is wrong') END AS mutuals_exact;

CREATE TEMP TABLE expected_suggestions (handle text);
INSERT INTO expected_suggestions VALUES ('diya');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_suggestions EXCEPT SELECT handle FROM ada_safe_suggestions)
  UNION ALL
  (SELECT handle FROM ada_safe_suggestions EXCEPT SELECT * FROM expected_suggestions)
) THEN 1 ELSE fail_test('Ada safe suggestions set is wrong') END AS suggestions_exact;

SELECT CASE WHEN (
  SELECT COUNT(*)
  FROM users ada
  JOIN follows first_hop ON first_hop.follower_id = ada.id
  JOIN follows second_hop ON second_hop.follower_id = first_hop.followee_id
  JOIN users candidate ON candidate.id = second_hop.followee_id
  WHERE ada.handle = 'ada' AND candidate.handle = 'diya'
) = 3 THEN 1 ELSE fail_test('Diya raw second-degree paths not proven') END AS diya_three_raw_paths;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE handle = 'noor') THEN 1 ELSE fail_test('Noor was suggested despite block') END AS noor_blocked_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE handle = 'theo') THEN 1 ELSE fail_test('Theo disconnected user was suggested') END AS theo_absent;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE handle = 'omar') THEN 1 ELSE fail_test('Omar incoming follower became suggestion') END AS omar_not_suggestion;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM ada_safe_suggestions WHERE handle IN ('ben', 'cy', 'maya')) THEN 1 ELSE fail_test('Already-followed user suggested') END AS already_followed_excluded;

