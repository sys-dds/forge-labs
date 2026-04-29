-- A mutual match is two LIKE edges in opposite directions.
CREATE VIEW mutual_matches AS SELECT a.swiper_id AS user_a_id, a.target_id AS user_b_id FROM swipes a JOIN swipes b ON b.swiper_id=a.target_id AND b.target_id=a.swiper_id WHERE a.direction='LIKE' AND b.direction='LIKE' AND a.swiper_id < a.target_id;
