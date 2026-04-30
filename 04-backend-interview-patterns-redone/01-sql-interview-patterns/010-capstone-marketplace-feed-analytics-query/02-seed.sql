SET search_path TO bip_sql_010;
INSERT INTO sellers VALUES (101,'Ben',8),(102,'Omar',45),(103,'Maya',18),(104,'Diya',22),(105,'Noor',12),(106,'Lina',30);
INSERT INTO listings VALUES (1001,101,'active',false),(1002,101,'active',false),(2001,102,'active',false),(3001,103,'active',false),(4001,104,'active',false),(5001,105,'active',true),(6001,106,'active',false);
INSERT INTO orders VALUES
(1,101,'completed',false),(2,101,'completed',false),(3,101,'completed',false),(4,101,'cancelled',false),
(5,102,'completed',true),(6,102,'cancelled',false),(7,102,'cancelled',true),(8,102,'completed',false),
(9,103,'completed',false),
(10,104,'completed',false),(11,104,'cancelled',false),(12,104,'completed',false),
(13,106,'completed',false);
INSERT INTO listing_events VALUES
(101,1001,'impression','2026-01-20'),(102,1001,'impression','2026-01-21'),(103,1001,'contact','2026-01-21'),(104,1001,'booking','2026-01-22'),(105,1002,'impression','2026-01-22'),(106,1002,'contact','2026-01-22'),(107,1002,'booking','2026-01-23'),
(201,2001,'impression','2026-01-20'),(202,2001,'impression','2026-01-21'),(203,2001,'impression','2026-01-22'),(204,2001,'contact','2026-01-22'),(205,2001,'booking','2026-01-23'),
(301,3001,'impression','2026-01-22'),(302,3001,'contact','2026-01-22'),
(401,4001,'impression','2026-01-20'),(402,4001,'impression','2026-01-21'),(403,4001,'impression','2026-01-22'),(404,4001,'contact','2026-01-22'),
(501,5001,'impression','2026-01-22'),(502,5001,'contact','2026-01-22'),
(601,6001,'impression','2025-12-01');
