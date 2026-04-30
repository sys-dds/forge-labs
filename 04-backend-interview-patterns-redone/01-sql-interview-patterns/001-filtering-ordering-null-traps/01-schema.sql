SET search_path TO bip_sql_001;
CREATE TABLE listings (listing_id integer PRIMARY KEY, title text NOT NULL, city text NOT NULL, status text NOT NULL, blocked_at timestamp, price_cents integer, quality_score integer NOT NULL);
