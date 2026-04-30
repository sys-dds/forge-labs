SET search_path TO bip_sql_024;
INSERT INTO listings VALUES (101,1,false),(102,1,false),(103,2,true),(104,3,false);
INSERT INTO moderation_decisions VALUES (1,101,'approved','2026-01-01 09:00','Ada'),(2,101,'limited','2026-01-03 09:00','Ben'),(3,102,'approved','2026-01-02 10:00','Cy'),(4,102,'rejected','2026-01-02 10:00','Diya'),(5,103,'approved','2026-01-04 09:00','Eli');
