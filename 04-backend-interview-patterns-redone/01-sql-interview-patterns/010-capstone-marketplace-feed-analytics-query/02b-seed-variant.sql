SET search_path TO bip_sql_010;
INSERT INTO sellers VALUES (201,'Iris',10),(202,'Jon',55),(203,'Kara',25),(204,'Mina',20);
INSERT INTO listings VALUES (7001,201,'active',false),(7002,201,'active',false),(8001,202,'active',false),(9001,203,'active',false),(9101,204,'active',false);
INSERT INTO orders VALUES
(21,201,'completed',false),(22,201,'completed',false),(23,201,'completed',false),
(24,202,'cancelled',true),(25,202,'completed',true),(26,202,'cancelled',false),
(27,203,'completed',false),(28,204,'completed',false),(29,204,'cancelled',false);
INSERT INTO listing_events VALUES
(701,7001,'impression','2026-01-20'),(702,7001,'contact','2026-01-20'),(703,7001,'booking','2026-01-21'),(704,7002,'impression','2026-01-22'),(705,7002,'contact','2026-01-22'),(706,7002,'booking','2026-01-23'),
(801,8001,'impression','2026-01-22'),(802,8001,'impression','2026-01-23'),(803,8001,'contact','2026-01-23'),
(901,9001,'impression','2026-01-22'),(902,9001,'impression','2026-01-23'),(903,9001,'impression','2026-01-24'),(904,9001,'contact','2026-01-24'),
(911,9101,'impression','2025-12-01');
