DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM listing_trigger_result WHERE status='paused' AND updated_at > '2026-01-01' AND old_status='active' AND new_status='paused' AND event_type='UPDATE') THEN RAISE EXCEPTION 'trigger audit wrong'; END IF;
END $$;