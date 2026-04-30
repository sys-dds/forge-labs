SET search_path TO bip_sql_026;
INSERT INTO sellers VALUES (101,'Ben'),(102,'Diya'),(103,'Omar'),(104,'Maya');
INSERT INTO orders VALUES (1,101,'completed',5000,0,'2026-03-02',false),(2,101,'cancelled',3000,0,'2026-03-03',false),(3,101,'disputed',7000,0,'2026-03-04',false),(4,101,'open',2000,0,'2026-03-05',false),(5,104,'refunded',6000,6000,'2026-03-06',false),(6,103,'cancelled',4000,0,'2026-03-02',false),(7,103,'cancelled',4500,0,'2026-03-03',false),(8,101,'completed',9000,0,'2026-03-04',true),(9,101,'completed',8000,0,'2026-02-25',false);
