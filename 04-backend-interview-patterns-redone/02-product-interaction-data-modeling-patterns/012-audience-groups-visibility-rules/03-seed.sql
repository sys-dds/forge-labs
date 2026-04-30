SET search_path TO bip_pim_012;
INSERT INTO users VALUES (1,'Ada','active'),(2,'Ben','active'),(3,'Cy','active'),(4,'Diya','active'),(5,'Eli','active'),(6,'Omar','active');
INSERT INTO audience_groups VALUES (401,4,'Diya close friends'),(402,5,'Eli close friends');
INSERT INTO audience_group_members VALUES (401,1),(402,3);
INSERT INTO friendships VALUES (1,3,'accepted'),(1,5,'pending');
INSERT INTO block_edges VALUES (6,1);
INSERT INTO posts VALUES (201,2,'public',NULL,NULL),(202,2,'private',NULL,NULL),(203,1,'private',NULL,NULL),(204,3,'friends_only',NULL,NULL),(205,4,'close_friends',401,NULL),(206,5,'close_friends',402,NULL),(207,6,'public',NULL,NULL),(208,2,'public',NULL,'2026-04-09 10:00');
