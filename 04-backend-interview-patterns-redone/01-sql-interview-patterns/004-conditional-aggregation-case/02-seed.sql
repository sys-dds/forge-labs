SET search_path TO bip_sql_004;
INSERT INTO sellers VALUES (101,'Ben'),(102,'Diya'),(103,'Maya'),(104,'Omar');
INSERT INTO orders VALUES
(1001,101,'completed',false),(1002,101,'completed',true),(1003,101,'cancelled',false),(1004,101,'pending',false),
(2001,102,'completed',false),(2002,102,'disputed',true),(2003,102,'cancelled',false),
(3001,103,'pending',false),(3002,103,'cancelled',false),
(4001,104,'completed',false),(4002,104,'completed',false);
