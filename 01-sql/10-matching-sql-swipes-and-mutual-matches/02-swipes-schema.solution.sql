CREATE TABLE swipes (
  swiper_id integer NOT NULL REFERENCES users(id),
  target_id integer NOT NULL REFERENCES users(id),
  direction text NOT NULL CHECK (direction IN ('LIKE','PASS')),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (swiper_id, target_id),
  CHECK (swiper_id <> target_id)
);
INSERT INTO swipes (swiper_id,target_id,direction) VALUES
  (1,2,'LIKE'), -- Ada likes Ben
  (2,1,'LIKE'), -- Ben likes Ada, creating the only mutual match
  (1,3,'PASS'), -- Ada passed Cy, so Cy liking Ada must not match
  (3,1,'LIKE');

