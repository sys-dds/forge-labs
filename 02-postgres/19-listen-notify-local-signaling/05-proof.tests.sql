DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM notify_payloads WHERE event_id=100 AND event_type='listing_created') THEN RAISE EXCEPTION 'notify payload helper wrong'; END IF;
IF NOT EXISTS (SELECT 1 FROM pg_proc WHERE proname='notify_domain_event') THEN RAISE EXCEPTION 'notify trigger function missing'; END IF;
END $$;