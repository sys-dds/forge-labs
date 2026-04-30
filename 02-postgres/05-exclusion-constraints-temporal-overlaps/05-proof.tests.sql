DO $$ BEGIN
IF (SELECT booking_count FROM provider_booking_counts WHERE provider='ben') <> 2 THEN RAISE EXCEPTION 'adjacent booking was not allowed'; END IF;
BEGIN INSERT INTO bookings VALUES (4,'ben',tstzrange('2026-01-01 09:30+00','2026-01-01 10:30+00','[)')); RAISE EXCEPTION 'overlap accepted'; EXCEPTION WHEN exclusion_violation THEN NULL; END;
END $$;