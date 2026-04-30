CREATE SCHEMA app; CREATE SCHEMA audit; CREATE SCHEMA internal; CREATE SCHEMA demo;
CREATE TABLE app.users(id int PRIMARY KEY, handle text);
CREATE TABLE demo.users(id int PRIMARY KEY, handle text);
CREATE TABLE audit.events(id int PRIMARY KEY, event_type text);
CREATE FUNCTION internal.normalized_handle(h text) RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT lower(trim(h)) $$;