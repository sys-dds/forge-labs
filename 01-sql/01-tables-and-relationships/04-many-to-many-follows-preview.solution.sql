-- A follow relationship connects users to other users, so it is a self-referencing many-to-many table.
-- The composite primary key is the first preview of duplicate relationship protection.
CREATE TABLE follows_preview (follower_id integer NOT NULL REFERENCES users(id), followee_id integer NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY (follower_id, followee_id));
INSERT INTO follows_preview (follower_id, followee_id) VALUES (1,2),(1,3),(2,1);
