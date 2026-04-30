SET search_path TO bip_sql_028;
CREATE TABLE order_status_events(event_id int PRIMARY KEY, order_id int NOT NULL, status text NOT NULL, event_at timestamp NOT NULL);
