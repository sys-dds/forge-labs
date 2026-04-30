SET search_path TO bip_sql_004;
CREATE TABLE sellers (seller_id integer PRIMARY KEY, seller_name text NOT NULL);
CREATE TABLE orders (order_id integer PRIMARY KEY, seller_id integer NOT NULL REFERENCES sellers(seller_id), status text NOT NULL, refunded boolean NOT NULL DEFAULT false);
