CREATE TABLE listings(id int PRIMARY KEY, seller text, status text);
CREATE TABLE status_audit(id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY, listing_id int, old_status text, new_status text);
CREATE FUNCTION audit_status_guarded() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN INSERT INTO status_audit(listing_id,old_status,new_status) VALUES (NEW.id,OLD.status,NEW.status); RETURN NEW; END $$;
CREATE TRIGGER status_audit_trg AFTER UPDATE ON listings FOR EACH ROW WHEN (OLD.status IS DISTINCT FROM NEW.status) EXECUTE FUNCTION audit_status_guarded();