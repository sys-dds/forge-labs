SET search_path TO bip_sql_011;
CREATE TABLE sellers (seller_id integer PRIMARY KEY, seller_name text NOT NULL, active boolean NOT NULL, avg_response_minutes integer NOT NULL);
CREATE TABLE listings (listing_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL);
CREATE TABLE orders (order_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, disputed boolean NOT NULL DEFAULT false);
CREATE TABLE listing_impressions (impression_id integer PRIMARY KEY, listing_id integer NOT NULL REFERENCES listings(listing_id), impression_at date NOT NULL);
