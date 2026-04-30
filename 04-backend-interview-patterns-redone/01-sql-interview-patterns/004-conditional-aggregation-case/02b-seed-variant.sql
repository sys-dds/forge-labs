SET search_path TO bip_sql_004;
INSERT INTO sellers VALUES (201,'Iris'),(202,'Jon'),(203,'Kara');
INSERT INTO orders VALUES
(5001,201,'completed',false),(5002,201,'completed',false),(5003,201,'disputed',true),(5004,201,'cancelled',false),
(6001,202,'pending',false),(6002,202,'cancelled',false),(6003,202,'disputed',false),
(7001,203,'completed',true);
