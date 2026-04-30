SET search_path TO bip_pim_026;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya');
INSERT INTO conversations VALUES (101,'direct',1,'active'),(102,'group',1,'active'),(103,'direct',1,'active');
INSERT INTO conversation_participants VALUES (201,101,1,'active',1,NULL),(202,101,2,'active',1,NULL),(203,102,1,'active',1,NULL),(204,102,2,'left',1,2),(205,102,3,'active',1,NULL),(206,103,1,'active',1,NULL),(207,103,3,'active',1,NULL);
INSERT INTO messages VALUES (1001,101,1,'hi ben',1),(1002,102,2,'before leaving',2),(1003,102,3,'after ben left',3),(1004,102,4,'invalid outsider',4);
INSERT INTO block_edges VALUES (1,3);
