DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM backend_type_checks WHERE request_id=100 AND price=19.99 AND payment_boundary_amount=19.99 AND request_after_listing AND active AND seller_uuid_text) THEN RAISE EXCEPTION 'typed facts did not compare exactly'; END IF;
BEGIN INSERT INTO backend_users VALUES ('00000000-0000-0000-0000-0000000000e1','','buyer',true); RAISE EXCEPTION 'empty handle accepted'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;
