SET search_path TO bank_r2_004;
INSERT INTO accounts VALUES (101,'Ada Current','GBP'),(201,'Merchant Clearing','GBP');
INSERT INTO ledger_transactions VALUES (9001,'tx-posted-1','posted','GBP'),(9002,'tx-posted-2','reversed','GBP'),(9003,'tx-reversal-1','posted','GBP');
INSERT INTO ledger_entries VALUES (1,9001,101,'debit',4000),(2,9001,201,'credit',4000),(3,9002,101,'debit',7000),(4,9002,201,'credit',7000),(5,9003,101,'credit',7000),(6,9003,201,'debit',7000);
INSERT INTO transaction_events VALUES (1,'tx-pending-1',101,'pending',2500,'2026-05-01 09:00','authorization'),(2,'tx-posted-1',101,'pending',4000,'2026-05-01 09:05','authorization'),(3,'tx-posted-1',101,'posted',4000,'2026-05-01 10:00','settled'),(4,'tx-failed-1',101,'pending',3000,'2026-05-01 09:10','authorization'),(5,'tx-failed-1',101,'failed',3000,'2026-05-01 09:20','declined'),(6,'tx-posted-2',101,'posted',7000,'2026-05-01 11:00','settled'),(7,'tx-posted-2',101,'reversed',7000,'2026-05-01 12:00','merchant reversal'),(8,'tx-reversal-1',101,'posted',7000,'2026-05-01 12:01','reversal posted');
INSERT INTO reversals VALUES (7001,'tx-posted-2','tx-reversal-1','merchant reversal');
