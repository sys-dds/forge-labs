CREATE OR REPLACE VIEW ada_seen_profiles AS
SELECT swiped.handle AS seen_handle, swipes.action
FROM users AS ada
JOIN swipes
  ON swipes.swiper_id = ada.id
JOIN users AS swiped
  ON swiped.id = swipes.swiped_id
WHERE ada.handle = 'ada';

CREATE OR REPLACE VIEW ada_mutual_matches AS
SELECT NULL::text AS matched_handle
WHERE false;

CREATE OR REPLACE VIEW ada_raw_candidates AS
SELECT NULL::text AS candidate_handle
WHERE false;

CREATE OR REPLACE VIEW ada_preference_fit_candidates AS
SELECT NULL::text AS candidate_handle, 0::integer AS shared_interest_count
WHERE false;
