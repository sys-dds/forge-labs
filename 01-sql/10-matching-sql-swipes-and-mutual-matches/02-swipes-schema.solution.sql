-- The pair is the action identity: one swiper can only decide once per target.
CREATE TABLE swipes (swiper_id integer REFERENCES users(id), target_id integer REFERENCES users(id), direction text NOT NULL CHECK(direction IN ('LIKE','PASS')), created_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY(swiper_id,target_id), CHECK(swiper_id<>target_id));
INSERT INTO swipes (swiper_id,target_id,direction) VALUES (1,2,'LIKE'),(2,1,'LIKE'),(1,4,'PASS'),(3,1,'LIKE');
