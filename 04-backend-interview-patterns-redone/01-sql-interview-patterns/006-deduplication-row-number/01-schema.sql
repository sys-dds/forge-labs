SET search_path TO bip_sql_006;
CREATE TABLE listing_status_events (event_id integer PRIMARY KEY, listing_id integer NOT NULL, status text NOT NULL, event_at timestamp NOT NULL);
