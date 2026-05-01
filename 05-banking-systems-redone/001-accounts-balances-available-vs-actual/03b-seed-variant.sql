SET search_path TO bank_r2_001;
INSERT INTO customers VALUES (1,'Ada'),(2,'Ben');
INSERT INTO accounts VALUES (101,1,'Ada Current','current','GBP','active'),(102,1,'Ada Old Savings','savings','GBP','closed'),(103,2,'Ben Current','current','GBP','active');
INSERT INTO posted_balance_snapshots VALUES (1,101,100000,'2026-05-01 09:00'),(2,102,20000,'2026-05-01 09:00'),(3,103,50000,'2026-05-01 09:00');
INSERT INTO account_holds VALUES (201,101,25000,'pending','2026-05-03 00:00',NULL,'larger hotel hold'),(202,101,5000,'released','2026-05-03 00:00','2026-05-01 10:00','released fuel hold'),(203,101,7000,'expired','2026-04-30 00:00',NULL,'old auth'),(204,103,8000,'pending','2026-05-03 00:00',NULL,'card hold');
INSERT INTO account_status_events VALUES (301,101,'active','2026-01-01','opened'),(302,102,'closed','2026-04-01','customer closed'),(303,103,'active','2026-01-02','opened');
