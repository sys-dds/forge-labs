DO $$ BEGIN
IF array(SELECT id FROM job_claim_result WHERE status='running' AND worker_id='worker-a' ORDER BY id) <> ARRAY[1,4] THEN RAISE EXCEPTION 'eligible jobs not claimed exactly'; END IF;
IF EXISTS (SELECT 1 FROM job_claim_result WHERE id IN (2,3) AND worker_id='worker-a') THEN RAISE EXCEPTION 'future or running job claimed'; END IF;
END $$;