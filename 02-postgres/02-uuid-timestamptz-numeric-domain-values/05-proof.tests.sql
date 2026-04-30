DO $$ BEGIN
IF EXISTS (SELECT 1 FROM inbound_requests WHERE id IS NULL) THEN RAISE EXCEPTION 'uuid missing'; END IF;
IF (SELECT exact_total FROM request_amount_summary WHERE actor='ada') <> 12.10 THEN RAISE EXCEPTION 'numeric drift'; END IF;
BEGIN INSERT INTO inbound_requests(actor, external_ref, amount, happened_at) VALUES ('ada','bad-negative',-1,'2026-01-01'); RAISE EXCEPTION 'negative accepted'; EXCEPTION WHEN check_violation THEN NULL; END;
BEGIN INSERT INTO inbound_requests(actor, external_ref, amount, happened_at) VALUES ('ada','   ',1,'2026-01-01'); RAISE EXCEPTION 'empty ref accepted'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;