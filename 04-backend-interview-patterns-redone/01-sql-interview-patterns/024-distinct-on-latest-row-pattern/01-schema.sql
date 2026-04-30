SET search_path TO bip_sql_024;
CREATE TABLE listings(listing_id int PRIMARY KEY, seller_id int NOT NULL, deleted boolean NOT NULL);
CREATE TABLE moderation_decisions(decision_id int PRIMARY KEY, listing_id int NOT NULL, decision text NOT NULL, decided_at timestamp NOT NULL, reviewer text NOT NULL);
