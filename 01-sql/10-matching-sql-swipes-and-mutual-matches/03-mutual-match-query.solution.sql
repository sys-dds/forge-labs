-- A match is derived only from two LIKE rows. PASS is a durable decision but not
-- positive intent, so Ada/Cy must not appear here.
CREATE VIEW mutual_matches AS
SELECT least(a.swiper_id, a.target_id) AS user_a_id,
       greatest(a.swiper_id, a.target_id) AS user_b_id,
       ua.handle AS user_a_handle,
       ub.handle AS user_b_handle
FROM swipes a
JOIN swipes b ON b.swiper_id = a.target_id AND b.target_id = a.swiper_id
JOIN users ua ON ua.id = least(a.swiper_id, a.target_id)
JOIN users ub ON ub.id = greatest(a.swiper_id, a.target_id)
WHERE a.direction = 'LIKE' AND b.direction = 'LIKE' AND a.swiper_id < a.target_id;

