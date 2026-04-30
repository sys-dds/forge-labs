SET search_path TO bip_sql_003;
INSERT INTO creators VALUES (101,'Ben'),(102,'Diya'),(103,'Maya'),(104,'Omar');
INSERT INTO posts VALUES
(1001,101,'published',15,NULL),(1002,101,'published',0,NULL),(1003,101,'published',22,NULL),(1004,101,'draft',50,NULL),
(2001,102,'published',30,NULL),(2002,102,'published',NULL,NULL),(2003,102,'published',4,NULL),(2004,102,'published',10,'2026-01-02'),
(3001,103,'published',11,NULL),(3002,103,'published',14,NULL),(3003,103,'published',20,NULL),
(4001,104,'published',50,NULL),(4002,104,'draft',50,NULL),(4003,104,'deleted',50,'2026-01-01');
