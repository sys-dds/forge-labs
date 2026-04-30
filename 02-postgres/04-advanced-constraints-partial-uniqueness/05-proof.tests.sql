DO $$ BEGIN
IF EXISTS (SELECT 1 FROM active_listing_slugs WHERE active_count<>1) THEN RAISE EXCEPTION 'active slug uniqueness broken'; END IF;
BEGIN INSERT INTO seller_listings VALUES (4,'ben','bicycle-repair','active',25); RAISE EXCEPTION 'duplicate active accepted'; EXCEPTION WHEN unique_violation THEN NULL; END;
BEGIN INSERT INTO seller_listings VALUES (5,'ben','bad','active',0); RAISE EXCEPTION 'zero price accepted'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;