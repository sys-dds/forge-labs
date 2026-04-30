CREATE TABLE listings(id int PRIMARY KEY, title text, status text, updated_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE listing_audit(id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY, listing_id int, old_status text, new_status text, event_type text);
CREATE FUNCTION touch_listing_updated_at() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN NEW.updated_at = now(); RETURN NEW; END $$;
CREATE FUNCTION audit_listing_change() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN INSERT INTO listing_audit(listing_id,old_status,new_status,event_type) VALUES (NEW.id,OLD.status,NEW.status,TG_OP); RETURN NEW; END $$;
CREATE TRIGGER listing_touch BEFORE UPDATE ON listings FOR EACH ROW EXECUTE FUNCTION touch_listing_updated_at();
CREATE TRIGGER listing_audit_trg AFTER UPDATE ON listings FOR EACH ROW WHEN (OLD.status IS DISTINCT FROM NEW.status) EXECUTE FUNCTION audit_listing_change();