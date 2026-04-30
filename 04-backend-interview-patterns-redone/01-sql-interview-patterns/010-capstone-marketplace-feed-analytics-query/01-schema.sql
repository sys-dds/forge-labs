SET search_path TO bip_sql_010;
CREATE TABLE sellers (seller_id integer PRIMARY KEY, seller_name text NOT NULL, avg_response_minutes integer NOT NULL);
CREATE TABLE listings (listing_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, blocked boolean NOT NULL);
CREATE TABLE orders (order_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, disputed boolean NOT NULL DEFAULT false);
CREATE TABLE listing_events (event_id integer PRIMARY KEY, listing_id integer NOT NULL REFERENCES listings(listing_id), event_name text NOT NULL, event_at date NOT NULL);
