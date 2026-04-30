CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE);

CREATE TABLE feed_candidates (
  post_id integer PRIMARY KEY,
  author_id integer NOT NULL REFERENCES users(id),
  candidate_reason text NOT NULL,
  recency_bucket text NOT NULL CHECK (recency_bucket IN ('recent', 'older')),
  like_count integer NOT NULL,
  comment_count integer NOT NULL,
  created_at timestamp NOT NULL
);

CREATE TABLE prior_replies (
  viewer_id integer NOT NULL REFERENCES users(id),
  author_id integer NOT NULL REFERENCES users(id),
  reply_count integer NOT NULL,
  PRIMARY KEY (viewer_id, author_id)
);

