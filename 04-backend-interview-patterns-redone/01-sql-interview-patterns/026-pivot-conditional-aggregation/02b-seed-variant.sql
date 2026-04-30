SET search_path TO bip_sql_026;
INSERT INTO sellers VALUES (201,'Iris'),(202,'Jon'),(203,'Kara');
INSERT INTO orders VALUES (11,201,'completed',10000,0,'2026-03-02',false),(12,201,'completed',8000,0,'2026-03-03',false),(13,201,'refunded',5000,2500,'2026-03-04',false),(14,202,'open',2000,0,'2026-03-05',false),(15,202,'cancelled',3000,0,'2026-03-06',false),(16,203,'completed',12000,0,'2026-03-04',true);
