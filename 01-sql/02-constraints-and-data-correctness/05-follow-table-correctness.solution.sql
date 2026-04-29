-- The database is the final duplicate-follow guard when two requests race.
CREATE TABLE follows (follower_id integer NOT NULL REFERENCES users(id), followee_id integer NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY (follower_id, followee_id), CHECK (follower_id <> followee_id));
INSERT INTO follows (follower_id, followee_id) VALUES (1,2),(1,3),(2,1),(3,2);
