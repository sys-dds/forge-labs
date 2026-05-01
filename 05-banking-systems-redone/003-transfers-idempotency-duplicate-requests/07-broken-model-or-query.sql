SET search_path TO bank_r2_003;
WITH attempt_postings AS (SELECT idempotency_key, COUNT(*) AS created_ledgers FROM transfer_attempts WHERE attempt_state IN ('created','duplicate_returned','conflict') GROUP BY idempotency_key)
SELECT 'first_request_created_transfer' AS contract_name, transfer_id::text AS subject_id, request_state AS observed_value, 'first request creates posted transfer 3001' AS expected_reason FROM transfer_requests WHERE transfer_id=3001
UNION ALL SELECT 'retry_same_key_same_result', idempotency_key, COUNT(*)::text || '=' || COUNT(*)::text, 'same key and fingerprint returns same transfer id' FROM transfer_attempts WHERE idempotency_key='idem-rent-001' GROUP BY idempotency_key
UNION ALL SELECT 'duplicate_no_second_ledger_transaction', '3001', created_ledgers::text, 'duplicate retry does not create a second ledger transaction' FROM attempt_postings WHERE idempotency_key='idem-rent-001'
UNION ALL SELECT 'conflicting_key_detected', idempotency_key, '0', 'same key with different fingerprint becomes conflict' FROM attempt_postings WHERE idempotency_key='idem-rent-001'
UNION ALL SELECT 'failed_attempt_retry_rule', idempotency_key, attempt_state, 'failed attempt is marked retryable and has no posted ledger rows' FROM transfer_attempts WHERE idempotency_key='idem-rent-002'
UNION ALL SELECT 'idempotency_debug_trace', idempotency_key, COUNT(*)::text, 'attempt rows explain first call retry conflict and failed retry rule' FROM transfer_attempts GROUP BY idempotency_key HAVING idempotency_key='idem-rent-001'
ORDER BY contract_name;
