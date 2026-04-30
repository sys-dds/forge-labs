SET search_path TO bip_sql_003;
INSERT INTO creators VALUES (201,'Iris'),(202,'Jon'),(203,'Kara');
INSERT INTO posts VALUES
(5001,201,'published',9,NULL),(5002,201,'published',10,NULL),(5003,201,'published',11,NULL),(5004,201,'published',NULL,NULL),
(6001,202,'published',20,NULL),(6002,202,'published',NULL,NULL),(6003,202,'published',1,NULL),
(7001,203,'published',30,NULL),(7002,203,'published',40,NULL),(7003,203,'published',50,NULL),(7004,203,'published',60,'2026-01-01');
