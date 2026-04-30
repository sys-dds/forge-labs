SET search_path TO bip_sql_024;
INSERT INTO listings VALUES (201,1,false),(202,2,false),(203,3,false),(204,4,true);
INSERT INTO moderation_decisions VALUES (11,201,'approved','2026-02-01 09:00','Iris'),(12,201,'rejected','2026-02-03 09:00','Jon'),(13,201,'approved','2026-02-04 09:00','Kara'),(14,202,'limited','2026-02-02 10:00','Mina'),(15,203,'approved','2026-02-01 10:00','Niko'),(16,203,'limited','2026-02-01 10:00','Ola'),(17,204,'rejected','2026-02-05 10:00','Pia');
