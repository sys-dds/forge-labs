DO $$ BEGIN
IF (SELECT verified_review_count FROM live_trust WHERE handle='ben') <> 2 THEN RAISE EXCEPTION 'live view not current'; END IF;
IF (SELECT verified_review_count FROM trust_after_refresh WHERE handle='ben') <> 2 THEN RAISE EXCEPTION 'materialized view did not refresh'; END IF;
END $$;