SET search_path TO bip_sql_026;
CREATE TABLE sellers(seller_id int PRIMARY KEY, seller_name text NOT NULL);
CREATE TABLE orders(order_id int PRIMARY KEY, seller_id int NOT NULL, status text NOT NULL, amount_pence int NOT NULL, refund_amount_pence int NOT NULL DEFAULT 0, ordered_at date NOT NULL, is_test boolean NOT NULL);
