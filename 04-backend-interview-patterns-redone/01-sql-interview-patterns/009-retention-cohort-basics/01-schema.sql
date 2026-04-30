SET search_path TO bip_sql_009;
CREATE TABLE creators (creator_id integer PRIMARY KEY, creator_name text NOT NULL, signup_date date NOT NULL);
CREATE TABLE creator_activity (activity_id integer PRIMARY KEY, creator_id integer NOT NULL REFERENCES creators(creator_id), activity_date date NOT NULL, activity_type text NOT NULL);
