DO $$ BEGIN
IF (SELECT count(*) FROM create_requests WHERE actor='ada' AND idem_key='create-1') <> 1 THEN RAISE EXCEPTION 'duplicate Ada request created'; END IF;
IF NOT EXISTS (SELECT 1 FROM create_requests WHERE actor='ben' AND idem_key='create-1') THEN RAISE EXCEPTION 'scoped key blocked Ben'; END IF;
IF NOT EXISTS (SELECT 1 FROM create_requests WHERE actor='ada' AND immutable_payload='listing=10' AND status='processed') THEN RAISE EXCEPTION 'upsert changed immutable facts or missed status'; END IF;
END $$;