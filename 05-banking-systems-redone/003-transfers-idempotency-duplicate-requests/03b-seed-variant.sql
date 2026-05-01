SET search_path TO bank_r2_003;
INSERT INTO accounts VALUES (101,'Ada Current','GBP'),(202,'Ben Current','GBP');
INSERT INTO ledger_transactions VALUES (9001,'posted','GBP');
INSERT INTO ledger_entries VALUES (1,9001,101,'debit',12000),(2,9001,202,'credit',12000);
INSERT INTO transfer_requests VALUES (3001,101,202,12000,'GBP','posted',9001),(3002,101,202,5000,'GBP','failed',NULL);
INSERT INTO idempotency_keys VALUES (1,'idem-rent-001','from101-to202-12000',3001,'active'),(2,'idem-rent-002','from101-to202-5000',3002,'failed');
INSERT INTO transfer_attempts VALUES (1,'idem-rent-001','from101-to202-12000','created',3001,'2026-05-01 09:00'),(2,'idem-rent-001','from101-to202-12000','duplicate_returned',3001,'2026-05-01 09:01'),(3,'idem-rent-001','from101-to202-12000','duplicate_returned',3001,'2026-05-01 09:02'),(4,'idem-rent-002','from101-to202-5000','failed_retryable',3002,'2026-05-01 09:03');
