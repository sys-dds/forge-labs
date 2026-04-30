SET search_path TO bip_pim_023;
CREATE TABLE sellers (seller_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE listings (listing_id int PRIMARY KEY, seller_id int REFERENCES sellers, status text NOT NULL);
CREATE TABLE orders (order_id int PRIMARY KEY, seller_id int REFERENCES sellers, order_state text NOT NULL);
CREATE TABLE seller_response_events (response_id int PRIMARY KEY, seller_id int REFERENCES sellers, response_minutes int NOT NULL);
CREATE TABLE seller_reviews (review_id int PRIMARY KEY, seller_id int REFERENCES sellers, rating int NOT NULL);
CREATE TABLE disputes (dispute_id int PRIMARY KEY, seller_id int REFERENCES sellers, state text NOT NULL);
CREATE TABLE seller_quality_components (component_id int PRIMARY KEY, seller_id int REFERENCES sellers, component_type text NOT NULL, component_value int NOT NULL);
CREATE TABLE seller_quality_snapshots (snapshot_id int PRIMARY KEY, seller_id int REFERENCES sellers, component_total int NOT NULL, treatment text NOT NULL);
