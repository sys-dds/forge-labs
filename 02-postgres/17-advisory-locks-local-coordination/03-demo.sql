SELECT claim_coordination_job('nightly-reconcile','worker-a') AS worker_a_claimed_reconcile;
SELECT claim_coordination_job('nightly-reconcile','worker-b') AS worker_b_second_claim;
SELECT job_name, claimed_by
FROM coordination_jobs
ORDER BY id;
