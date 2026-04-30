SET search_path TO bip_sql_003;
CREATE TABLE creators (creator_id integer PRIMARY KEY, creator_name text NOT NULL);
CREATE TABLE posts (post_id integer PRIMARY KEY, creator_id integer NOT NULL REFERENCES creators(creator_id), status text NOT NULL, engagement_count integer, deleted_at timestamp);
