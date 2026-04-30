SET search_path TO bip_pim_008;
INSERT INTO users VALUES (1,'Ada','active'),(2,'Ben','active'),(3,'Cy','active'),(4,'Diya','active');
INSERT INTO posts VALUES (701,2,'2026-04-05 11:30'),(702,2,NULL),(703,2,NULL),(704,4,NULL);
INSERT INTO follow_edges VALUES (1,2,'active'),(3,2,'active'),(1,4,'active');
INSERT INTO block_edges VALUES (2,3);
INSERT INTO visibility_rules VALUES ('public',true,true),('private',false,true),('followers',true,true);
INSERT INTO activity_events VALUES (8001,2,'posted','post',702,NULL,'public','2026-04-05 10:00'),(8002,2,'liked','post',703,NULL,'private','2026-04-05 10:10'),(8003,4,'posted','post',704,NULL,'followers','2026-04-05 10:20'),(8004,2,'posted','post',701,NULL,'public','2026-04-05 10:30');
