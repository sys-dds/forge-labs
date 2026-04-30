SET search_path TO bip_sql_013;
CREATE TABLE price_events (price_event_id integer PRIMARY KEY, listing_id integer NOT NULL, price_pence integer NOT NULL, changed_at timestamp NOT NULL);
