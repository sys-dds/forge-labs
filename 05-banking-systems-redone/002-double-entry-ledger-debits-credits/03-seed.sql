SET search_path TO bank_r2_002;
INSERT INTO currencies VALUES ('GBP'),('USD');
INSERT INTO accounts VALUES (101,'Ada Current','current','GBP'),(201,'Bank Clearing','clearing','GBP'),(301,'USD Clearing','clearing','USD');
INSERT INTO ledger_transactions VALUES (9001,'posted card settlement','GBP','posted'),(9002,'bad imported adjustment','GBP','posted'),(9003,'usd sample','USD','posted');
INSERT INTO ledger_entries VALUES (1,9001,101,'credit',50000,1,'2026-05-01 09:00'),(2,9001,201,'debit',50000,2,'2026-05-01 09:00'),(3,9002,101,'debit',3000,1,'2026-05-01 10:00'),(4,9002,201,'credit',2500,2,'2026-05-01 10:00'),(5,9003,301,'credit',1000,1,'2026-05-01 11:00'),(6,9003,301,'debit',1000,2,'2026-05-01 11:00');
INSERT INTO ledger_entry_metadata VALUES (1,1,'source','card_settlement'),(2,3,'source','manual_import');
