SET search_path TO bip_sql_002;
CREATE TABLE users (user_id integer PRIMARY KEY, user_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE required_checks (check_name text PRIMARY KEY);
CREATE TABLE user_checks (user_id integer NOT NULL REFERENCES users(user_id), check_name text NOT NULL REFERENCES required_checks(check_name), status text NOT NULL, PRIMARY KEY (user_id, check_name));
