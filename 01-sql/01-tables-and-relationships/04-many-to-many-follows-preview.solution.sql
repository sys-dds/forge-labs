-- follows_preview introduces a directed many-to-many relationship. The composite
-- key is the duplicate-follow protection that later social graph chapters rely on.
CREATE TABLE follows_preview (
  follower_id integer NOT NULL REFERENCES users(id),
  followee_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (follower_id, followee_id),
  CHECK (follower_id <> followee_id)
);
INSERT INTO follows_preview VALUES (1,2),(1,3);

