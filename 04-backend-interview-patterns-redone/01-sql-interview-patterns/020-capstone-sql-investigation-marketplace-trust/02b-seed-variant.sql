SET search_path TO bip_sql_020;
INSERT INTO sellers VALUES (201,'Iris'),(202,'Jon'),(203,'Kara'),(204,'Mina');
INSERT INTO listings VALUES (8001,201,'active',false),(8002,201,'active',false),(9001,202,'active',false),(9101,203,'active',false),(9201,204,'active',false);
INSERT INTO orders VALUES (101,201,'completed','2026-02-01'),(102,201,'completed','2026-02-02'),(103,201,'completed','2026-02-03'),(104,202,'completed','2026-02-01'),(105,202,'cancelled','2026-02-02'),(106,202,'cancelled','2026-02-03'),(107,203,'completed','2026-02-01'),(108,203,'completed','2026-02-02'),(109,204,'completed','2026-02-01');
INSERT INTO disputes VALUES (101,105);
INSERT INTO refunds VALUES (101,105);
INSERT INTO response_events VALUES (101,201,12),(102,202,70),(103,203,24),(104,204,20);
INSERT INTO listing_impressions VALUES (101,8001,'impression','2026-01-26'),(102,8001,'contact','2026-01-26'),(103,8001,'booking','2026-01-27'),(104,8002,'impression','2026-01-27'),(105,8002,'contact','2026-01-27'),(106,8002,'booking','2026-01-28'),(107,9001,'impression','2026-01-28'),(108,9001,'impression','2026-01-29'),(109,9001,'contact','2026-01-29'),(110,9101,'impression','2026-01-28'),(111,9101,'impression','2026-01-29'),(112,9101,'impression','2026-01-30'),(113,9101,'impression','2026-01-31'),(114,9101,'impression','2026-02-01'),(115,9101,'contact','2026-02-01'),(116,9101,'booking','2026-02-01'),(117,9201,'impression','2026-01-30');
INSERT INTO fraud_cases VALUES (101,204,'closed');
