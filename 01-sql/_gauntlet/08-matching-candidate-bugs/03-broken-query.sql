CREATE OR REPLACE VIEW gauntlet_mutual_matches AS
SELECT other.handle FROM users ada JOIN swipes a ON a.swiper_id=ada.id JOIN swipes b ON b.swiper_id=a.swiped_id AND b.swiped_id=ada.id JOIN users other ON other.id=a.swiped_id WHERE ada.handle='ada';
CREATE OR REPLACE VIEW gauntlet_raw_candidates AS
SELECT candidate.handle FROM users ada JOIN users candidate ON candidate.id<>ada.id WHERE ada.handle='ada' ORDER BY candidate.handle;
CREATE OR REPLACE VIEW gauntlet_fit_candidates AS
SELECT c.handle, count(i2.interest)::integer AS shared_interest_count
FROM users ada JOIN prefs p ON p.user_id=ada.id JOIN users c ON c.id<>ada.id
LEFT JOIN interests i1 ON i1.user_id=ada.id LEFT JOIN interests i2 ON i2.user_id=c.id AND i2.interest=i1.interest
WHERE ada.handle='ada' AND c.age BETWEEN p.min_age AND p.max_age GROUP BY c.handle ORDER BY c.handle;
