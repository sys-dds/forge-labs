SET search_path TO bip_sql_020;
CREATE TABLE sellers (seller_id integer PRIMARY KEY, seller_name text NOT NULL);
CREATE TABLE listings (listing_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, blocked boolean NOT NULL);
CREATE TABLE orders (order_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, ordered_at date NOT NULL);
CREATE TABLE disputes (dispute_id integer PRIMARY KEY, order_id integer NOT NULL REFERENCES orders(order_id));
CREATE TABLE refunds (refund_id integer PRIMARY KEY, order_id integer NOT NULL REFERENCES orders(order_id));
CREATE TABLE response_events (response_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), response_minutes integer NOT NULL);
CREATE TABLE listing_impressions (event_id integer PRIMARY KEY, listing_id integer NOT NULL REFERENCES listings(listing_id), event_type text NOT NULL, event_at date NOT NULL);
CREATE TABLE fraud_cases (case_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL);
