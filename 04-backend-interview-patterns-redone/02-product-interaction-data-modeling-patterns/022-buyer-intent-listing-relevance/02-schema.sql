SET search_path TO bip_pim_022;
CREATE TABLE buyers (buyer_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE buyer_intents (intent_id int PRIMARY KEY, buyer_id int REFERENCES buyers, category text NOT NULL, max_price int NOT NULL, location text NOT NULL);
CREATE TABLE sellers (seller_id int PRIMARY KEY, display_name text NOT NULL, status text NOT NULL);
CREATE TABLE listings (listing_id int PRIMARY KEY, seller_id int REFERENCES sellers, title text NOT NULL, category text NOT NULL, price int NOT NULL, location text NOT NULL, status text NOT NULL, created_rank int NOT NULL);
CREATE TABLE listing_tags (listing_id int REFERENCES listings, tag text NOT NULL);
CREATE TABLE listing_availability (availability_id int PRIMARY KEY, listing_id int REFERENCES listings, available_state text NOT NULL);
CREATE TABLE seller_trust_components (component_id int PRIMARY KEY, seller_id int REFERENCES sellers, component_type text NOT NULL, component_value int NOT NULL);
CREATE TABLE buyer_seen_listings (seen_id int PRIMARY KEY, buyer_id int REFERENCES buyers, listing_id int REFERENCES listings);
