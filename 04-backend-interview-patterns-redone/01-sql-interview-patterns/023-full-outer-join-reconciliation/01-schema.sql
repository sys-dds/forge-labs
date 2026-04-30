SET search_path TO bip_sql_023;
CREATE TABLE orders(order_id int PRIMARY KEY, status text NOT NULL, amount_pence int NOT NULL);
CREATE TABLE ledger_entries(ledger_id int PRIMARY KEY, order_id int, posting_type text NOT NULL, amount_pence int NOT NULL);
