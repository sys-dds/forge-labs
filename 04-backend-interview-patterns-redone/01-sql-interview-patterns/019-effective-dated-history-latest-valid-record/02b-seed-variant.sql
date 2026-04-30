SET search_path TO bip_sql_019;
INSERT INTO trust_policies VALUES (11,'alpha','active','2026-02-01 00:00','2026-02-03 00:00'),(12,'beta','active','2026-02-03 00:00','2026-02-10 00:00'),(13,'gamma','active','2026-02-10 00:00',NULL),(14,'bad_overlap','draft','2026-02-02 00:00','2026-02-12 00:00');
INSERT INTO seller_events VALUES (201,20,'2026-01-31 23:00'),(202,20,'2026-02-02 12:00'),(203,20,'2026-02-03 00:00'),(204,20,'2026-02-11 09:00');
