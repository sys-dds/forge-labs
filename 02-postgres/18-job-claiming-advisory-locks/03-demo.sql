SELECT * FROM claim_due_jobs('worker-a','2026-01-02');
SELECT id, kind, status, worker_id, claimed_at
FROM jobs
ORDER BY id;
