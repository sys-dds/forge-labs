SET search_path TO bip_sql_029;
CREATE TABLE variant_events(variant_id text PRIMARY KEY, impressions int NOT NULL, clicks int NOT NULL, hides int NOT NULL, reports int NOT NULL);
