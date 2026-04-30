SET search_path TO bip_pim_031;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Eli'),(6,'Fay');
INSERT INTO communities VALUES (101,'Forge Guild','private',1);
INSERT INTO community_memberships VALUES (1001,101,1,'active','2026-01-01',NULL),(1002,101,2,'active','2026-01-02',NULL),(1003,101,3,'left','2026-01-03','2026-02-01'),(1004,101,4,'banned','2026-01-04','2026-02-02'),(1005,101,5,'active','2026-01-05',NULL);
INSERT INTO community_roles VALUES (201,101,'owner',100),(202,101,'admin',80),(203,101,'moderator',60),(204,101,'member',10);
INSERT INTO community_role_assignments VALUES (5001,101,1,201,1),(5002,101,2,203,1),(5003,101,5,204,1),(5004,101,6,202,1);
INSERT INTO community_permissions VALUES (9001,101,201,'transfer_ownership',true),(9002,101,203,'remove_post',false),(9003,101,203,'transfer_ownership',false),(9004,101,204,'remove_post',false),(9005,101,202,'remove_post',true);
INSERT INTO community_bans VALUES (7001,101,4,1,'chargeback spam');

