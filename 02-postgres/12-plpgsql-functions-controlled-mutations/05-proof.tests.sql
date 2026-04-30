DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM dispute_resolution_result WHERE id=10 AND status='resolved' AND note='Maya confirmed refund') THEN RAISE EXCEPTION 'resolution or audit missing'; END IF;
BEGIN PERFORM resolve_dispute(10,'repeat'); RAISE EXCEPTION 'repeat resolution accepted'; EXCEPTION WHEN raise_exception THEN NULL; END;
END $$;