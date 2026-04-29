-- A composite primary key is ideal where the pair itself is the identity.
CREATE TABLE follows_base (follower_id integer NOT NULL REFERENCES users(id), followee_id integer NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY (follower_id, followee_id), CHECK (follower_id <> followee_id));
