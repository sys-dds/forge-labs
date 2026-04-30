DO $$ BEGIN
IF array(SELECT id FROM payment_payload_events ORDER BY id) <> ARRAY[3] THEN RAISE EXCEPTION 'jsonb containment result wrong'; END IF;
IF (SELECT count(*) FROM audit_events WHERE payload ? 'source') <> 1 THEN RAISE EXCEPTION 'optional key query wrong'; END IF;
END $$;