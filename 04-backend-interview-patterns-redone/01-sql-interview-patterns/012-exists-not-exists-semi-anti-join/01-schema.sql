SET search_path TO bip_sql_012;
CREATE TABLE buyers (buyer_id integer PRIMARY KEY, buyer_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE payment_methods (payment_method_id integer PRIMARY KEY, buyer_id integer NOT NULL REFERENCES buyers(buyer_id), verified boolean NOT NULL);
CREATE TABLE identity_checks (check_id integer PRIMARY KEY, buyer_id integer NOT NULL REFERENCES buyers(buyer_id), status text NOT NULL);
CREATE TABLE fraud_cases (case_id integer PRIMARY KEY, buyer_id integer NOT NULL REFERENCES buyers(buyer_id), status text NOT NULL);
CREATE TABLE chargebacks (chargeback_id integer PRIMARY KEY, buyer_id integer NOT NULL REFERENCES buyers(buyer_id), chargeback_at date NOT NULL);
