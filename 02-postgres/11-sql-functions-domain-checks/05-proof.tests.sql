DO $$ BEGIN
IF array(SELECT handle FROM eligible_sellers ORDER BY handle) <> ARRAY['ben'] THEN RAISE EXCEPTION 'eligible sellers wrong'; END IF;
IF is_seller_eligible(0,0,1) THEN RAISE EXCEPTION 'Cy condition passed incorrectly'; END IF;
END $$;