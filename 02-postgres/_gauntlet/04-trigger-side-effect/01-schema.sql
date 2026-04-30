CREATE TABLE listings(id int PRIMARY KEY, status text);
CREATE TABLE listing_audit(id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY, listing_id int, old_status text, new_status text);
CREATE FUNCTION audit_status() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN INSERT INTO listing_audit(listing_id,old_status,new_status) VALUES (NEW.id,OLD.status,NEW.status); RETURN NEW; END $$;