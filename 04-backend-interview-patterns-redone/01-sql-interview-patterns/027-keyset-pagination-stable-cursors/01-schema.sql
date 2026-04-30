SET search_path TO bip_sql_027;
CREATE TABLE listings(listing_id int PRIMARY KEY, ranking_score numeric(6,2) NOT NULL, blocked boolean NOT NULL);
CREATE TABLE page_cursor(last_score numeric(6,2) NOT NULL, last_listing_id int NOT NULL);
