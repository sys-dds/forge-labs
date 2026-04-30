DO $$ BEGIN
IF array(SELECT id FROM high_risk_events ORDER BY id) <> ARRAY[1] THEN RAISE EXCEPTION 'risk extraction wrong'; END IF;
IF (SELECT external_id FROM provider_events WHERE id=3) <> 'evt-77' THEN RAISE EXCEPTION 'generated projection wrong'; END IF;
BEGIN INSERT INTO provider_events VALUES (4,'provider','{}'); RAISE EXCEPTION 'missing provider external id accepted'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;