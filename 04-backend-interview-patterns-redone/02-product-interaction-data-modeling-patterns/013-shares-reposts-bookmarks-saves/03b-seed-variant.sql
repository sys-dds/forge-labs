SET search_path TO bip_pim_013;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Omar');
INSERT INTO posts VALUES (201,2,'Ben public','public',NULL),(202,2,'Ben restored','public',NULL),(203,4,'Omar public','public',NULL);
INSERT INTO reposts VALUES (301,1,201,'2026-04-10 09:00',NULL),(302,1,202,'2026-04-10 09:05',NULL),(303,1,203,'2026-04-10 09:10',NULL);
INSERT INTO quote_reposts VALUES (401,1,201,'Ada adds context','2026-04-10 09:15',NULL);
INSERT INTO bookmarks VALUES (501,1,201,'2026-04-10 10:00',NULL),(502,1,201,'2026-04-10 10:01','2026-04-10 10:05'),(503,3,201,'2026-04-10 10:02',NULL);
INSERT INTO block_edges VALUES (4,1);
