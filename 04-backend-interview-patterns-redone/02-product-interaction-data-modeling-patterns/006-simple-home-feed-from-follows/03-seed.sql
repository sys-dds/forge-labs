SET search_path TO bip_pim_006;
INSERT INTO users VALUES (1,'Ada','active'),(2,'Ben','active'),(3,'Cy','active'),(4,'Omar','active'),(5,'Noor','active'),(6,'Lina','inactive'),(7,'Eli','active');
INSERT INTO follow_edges VALUES (1,2,'active','2026-04-01 09:00'),(1,3,'active','2026-04-01 09:01'),(1,4,'active','2026-04-01 09:02'),(1,5,'active','2026-04-01 09:03'),(1,6,'active','2026-04-01 09:04'),(1,7,'unfollowed','2026-04-01 09:05');
INSERT INTO block_edges VALUES (1,4,'2026-04-02 10:00');
INSERT INTO mute_edges VALUES (1,5,'2026-04-02 10:05');
INSERT INTO posts VALUES (101,2,'Ben visible','2026-04-03 10:00',NULL),(102,3,'Cy visible newer','2026-04-03 11:00',NULL),(103,7,'Eli unfollowed','2026-04-03 12:00',NULL),(104,4,'Omar blocked','2026-04-03 13:00',NULL),(105,5,'Noor muted','2026-04-03 14:00',NULL),(106,2,'Ben deleted','2026-04-03 15:00','2026-04-03 15:10'),(107,6,'Lina inactive','2026-04-03 16:00',NULL),(108,3,'Cy same time tie high id','2026-04-03 11:00',NULL);
INSERT INTO feed_seen_events VALUES (1,101,'2026-04-04 08:00');
