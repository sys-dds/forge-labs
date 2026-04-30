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
    INSERT INTO profiles (id, user_id, profile_type, display_name) VALUES (1999, 1, 'buyer', 'Ada duplicate');
    RAISE EXCEPTION 'duplicate Ada profile was accepted';
  EXCEPTION WHEN unique_violation THEN NULL;
  END;

  BEGIN
    INSERT INTO saved_listings (user_id, listing_id) VALUES (1, 101);
    RAISE EXCEPTION 'duplicate Ada save for Ben listing 101 was accepted';
  EXCEPTION WHEN unique_violation THEN NULL;
  END;

  BEGIN
    INSERT INTO follows (follower_id, followed_id) VALUES (1, 1);
    RAISE EXCEPTION 'Ada self-follow was accepted';
  EXCEPTION WHEN check_violation THEN NULL;
  END;

  BEGIN
    INSERT INTO listings (id, seller_id, title) VALUES (999, 999, 'missing seller listing');
    RAISE EXCEPTION 'listing without an existing seller was accepted';
  EXCEPTION WHEN foreign_key_violation THEN NULL;
  END;
END $$;

SELECT 1
WHERE EXISTS (SELECT 1 FROM follows WHERE follower_id = 1 AND followed_id = 2)
  AND EXISTS (SELECT 1 FROM blocks WHERE blocker_id = 1 AND blocked_id = 3)
  AND EXISTS (SELECT 1 FROM users u WHERE u.handle = 'noor')
  AND NOT EXISTS (SELECT 1 FROM follows WHERE follower_id = 5 OR followed_id = 5)
  AND NOT EXISTS (SELECT 1 FROM blocks WHERE blocker_id = 5 OR blocked_id = 5);

SELECT CASE WHEN COUNT(*) = 2 THEN 1 ELSE fail_test('expected Ben listing 101 saved exactly once by Ada and exactly once by Diya; broken relationship model lost one save or allowed a duplicate user/listing fact') END AS ben_101_saved_by_ada_and_diya
FROM saved_listings
WHERE listing_id = 101 AND user_id IN (1, 4);
