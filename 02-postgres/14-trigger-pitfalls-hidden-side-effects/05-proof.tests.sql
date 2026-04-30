DO $$ BEGIN
IF (SELECT audit_count FROM trigger_side_effect_result) <> 2 THEN RAISE EXCEPTION 'bulk update audit count wrong or no-op logged'; END IF;
END $$;