SET search_path TO bip_pim_005;
INSERT INTO users VALUES (1,'Ada',true),(2,'Ben',true),(3,'Cy',true),(4,'Diya',true),(5,'Omar',true),(6,'Noor',true),(7,'Lina',true),(8,'Maya',true),(9,'Niko',true);
INSERT INTO user_profiles VALUES (1,'Glasgow',true),(2,'Glasgow',true),(3,'Glasgow',true),(4,'Glasgow',true),(5,'Glasgow',true),(6,'Glasgow',true),(7,'Glasgow',true),(8,'Glasgow',true),(9,'Glasgow',true);
INSERT INTO swipe_events VALUES (1,1,2,'right','2026-01-01'),(2,2,1,'right','2026-01-02'),(3,1,3,'right','2026-01-02'),(4,3,1,'right','2026-01-03'),(5,1,4,'left','2026-01-04'),(6,1,5,'right','2026-01-05'),(7,5,1,'right','2026-01-06'),(8,1,6,'right','2026-01-07'),(9,6,1,'right','2026-01-08'),(10,1,7,'right','2026-01-09'),(11,7,1,'right','2026-01-10');
INSERT INTO matches VALUES (401,1,2,'2026-01-02',NULL),(402,1,3,'2026-01-03',NULL),(403,1,7,'2026-01-10','2026-01-12');
INSERT INTO block_edges VALUES (1,5);
INSERT INTO report_events VALUES (1,1,6);
