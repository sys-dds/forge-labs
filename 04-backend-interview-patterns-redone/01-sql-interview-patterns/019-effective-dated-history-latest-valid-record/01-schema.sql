SET search_path TO bip_sql_019;
CREATE TABLE trust_policies (policy_id integer PRIMARY KEY, policy_version text NOT NULL, status text NOT NULL, effective_from timestamp NOT NULL, effective_to timestamp);
CREATE TABLE seller_events (event_id integer PRIMARY KEY, seller_id integer NOT NULL, event_time timestamp NOT NULL);
