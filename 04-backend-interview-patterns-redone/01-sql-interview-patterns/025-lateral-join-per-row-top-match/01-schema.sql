SET search_path TO bip_sql_025;
CREATE TABLE buyer_intents(buyer_id int PRIMARY KEY, city text NOT NULL, service_category text NOT NULL, budget_pence int NOT NULL);
CREATE TABLE sellers(seller_id int PRIMARY KEY, seller_name text NOT NULL, blocked boolean NOT NULL, seller_trust_score numeric(5,2) NOT NULL);
CREATE TABLE listings(listing_id int PRIMARY KEY, seller_id int NOT NULL, city text NOT NULL, service_category text NOT NULL, status text NOT NULL, price_pence int NOT NULL, distance_km numeric(5,2) NOT NULL);
