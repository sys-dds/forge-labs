SET search_path TO bip_pim_032;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Eli'),(6,'Fay');
INSERT INTO communities VALUES (101,'Private Foundry','private');
INSERT INTO community_join_requests VALUES (2001,101,1,'pending',NULL,NULL),(2002,101,2,'approved',6,'2026-03-01'),(2003,101,3,'rejected',6,'2026-03-02');
INSERT INTO community_invites VALUES (4004,101,4,6,'expired','2026-02-01',NULL),(4005,101,5,6,'accepted','2026-06-01','2026-03-03'),(4006,101,6,2,'accepted','2026-06-01','2026-03-04');
INSERT INTO community_memberships VALUES (3002,101,2,'active','request',2002),(3006,101,6,'active','invite',4006);
INSERT INTO community_bans VALUES (5005,101,5,6,'previous abuse');
INSERT INTO community_request_audit VALUES (6002,101,2002,NULL,6,'approve','2026-03-01'),(6003,101,2003,NULL,6,'reject','2026-03-02'),(6004,101,NULL,4004,6,'expire_invite','2026-03-03'),(6005,101,NULL,4005,6,'ban_suppressed','2026-03-03'),(6006,101,NULL,4006,2,'accept_invite','2026-03-04');
