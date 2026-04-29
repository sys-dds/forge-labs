-- A mutual match is not just any two swipe rows. It requires two LIKE actions
-- in opposite directions. PASS rows are stored as decisions, but they must not
-- produce matches.
CREATE VIEW mutual_matches AS
SELECT
  first_like.swiper_id AS user_a_id,
  first_like.target_id AS user_b_id
FROM swipes AS first_like
JOIN swipes AS second_like
  ON second_like.swiper_id = first_like.target_id
 AND second_like.target_id = first_like.swiper_id
WHERE first_like.direction = 'LIKE'
  AND second_like.direction = 'LIKE'
  AND first_like.swiper_id < first_like.target_id;
