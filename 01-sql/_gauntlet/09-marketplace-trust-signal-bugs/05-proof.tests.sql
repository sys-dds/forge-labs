DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE seller_handle='ben' AND active_listing_count=2 AND verified_review_count=1 AND suspicious_review_count=0 AND open_dispute_count=0 AND resolved_dispute_count=1) THEN
    RAISE EXCEPTION 'Ben trust signals are wrong';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM gauntlet_result WHERE seller_handle='cy' AND active_listing_count=1 AND verified_review_count=1 AND suspicious_review_count=2 AND open_dispute_count=1 AND resolved_dispute_count=0) THEN
    RAISE EXCEPTION 'Cy trust signals are wrong';
  END IF;
END $$;
SELECT 'PASS marketplace trust gauntlet' AS result;
