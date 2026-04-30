SET search_path TO bip_sql_005;
CREATE TABLE posts (post_id integer PRIMARY KEY, topic text NOT NULL, title text NOT NULL, score integer NOT NULL, unsafe boolean NOT NULL, deleted_at timestamp);
