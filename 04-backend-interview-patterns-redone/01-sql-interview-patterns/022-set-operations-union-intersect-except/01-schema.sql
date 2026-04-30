SET search_path TO bip_sql_022;
CREATE TABLE creators(creator_id int PRIMARY KEY, creator_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE posts(post_id int PRIMARY KEY, creator_id int NOT NULL, status text NOT NULL, safe boolean NOT NULL);
CREATE TABLE payout_onboarding(creator_id int PRIMARY KEY, completed boolean NOT NULL);
CREATE TABLE policy_violations(creator_id int PRIMARY KEY, open_violation boolean NOT NULL);
CREATE TABLE fraud_investigations(creator_id int PRIMARY KEY, open_case boolean NOT NULL);
