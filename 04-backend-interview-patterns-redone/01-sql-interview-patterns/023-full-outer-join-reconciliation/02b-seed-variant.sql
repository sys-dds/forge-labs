SET search_path TO bip_sql_023;
INSERT INTO orders VALUES (2001,'completed',5000),(2002,'completed',7000),(2004,'completed',9000),(2005,'refunded',4000),(2006,'cancelled',3000),(2007,'completed',6500);
INSERT INTO ledger_entries VALUES (9901,2001,'sale',5000),(9902,2002,'sale',7000),(9904,2004,'sale',9100),(9905,2005,'refund',-4000),(9907,2999,'sale',1200);
