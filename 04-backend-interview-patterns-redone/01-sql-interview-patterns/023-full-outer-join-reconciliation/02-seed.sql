SET search_path TO bip_sql_023;
INSERT INTO orders VALUES (1001,'completed',5000),(1002,'completed',7000),(1004,'completed',9000),(1005,'refunded',4000),(1006,'cancelled',3000);
INSERT INTO ledger_entries VALUES (9001,1001,'sale',5000),(9003,1999,'sale',2500),(9004,1004,'sale',8500),(9005,1005,'sale',4000);
