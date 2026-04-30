DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM seller_api_cards WHERE handle='ben' AND active_listing_count=1 AND verified_review_count=1 AND NOT has_open_dispute) THEN RAISE EXCEPTION 'Ben card wrong'; END IF;
IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='seller_api_cards' AND column_name='email') THEN RAISE EXCEPTION 'email leaked'; END IF;
END $$;