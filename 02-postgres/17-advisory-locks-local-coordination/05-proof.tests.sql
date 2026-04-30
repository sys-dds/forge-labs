DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM advisory_lock_claims WHERE job_name='nightly-reconcile' AND claimed_by='worker-a') THEN RAISE EXCEPTION 'first claim missing'; END IF;
IF NOT EXISTS (SELECT 1 FROM advisory_lock_claims WHERE job_name='payout-sweep' AND claimed_by='worker-b') THEN RAISE EXCEPTION 'different job not claimed'; END IF;
END $$;