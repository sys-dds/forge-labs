SET search_path TO bip_sql_015;
CREATE TABLE daily_listing_impressions (listing_id integer NOT NULL, activity_date date NOT NULL, impressions integer NOT NULL, PRIMARY KEY (listing_id, activity_date));
