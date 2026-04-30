SET search_path TO bip_sql_016;
CREATE TABLE creators (creator_id integer PRIMARY KEY, creator_name text NOT NULL, follower_count integer NOT NULL, completed_posts integer NOT NULL, avg_dwell_seconds integer NOT NULL, hide_count integer NOT NULL, report_count integer NOT NULL, trust_score integer NOT NULL);
