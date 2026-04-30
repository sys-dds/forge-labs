SET search_path TO bip_sql_008;
CREATE TABLE funnel_steps (step_name text PRIMARY KEY, step_order integer NOT NULL UNIQUE);
CREATE TABLE funnel_events (event_id integer PRIMARY KEY, user_id integer NOT NULL, event_name text NOT NULL REFERENCES funnel_steps(step_name), event_at timestamp NOT NULL);
