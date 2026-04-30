SET search_path TO bip_pim_005;
INSERT INTO users VALUES (1,'Ada',true),(2,'Ben',true),(3,'Cy',true),(4,'Diya',true),(5,'Omar',true),(6,'Noor',true),(7,'Lina',true),(8,'Maya',true);
INSERT INTO user_profiles VALUES (1,'Glasgow',true),(2,'Glasgow',true),(3,'Glasgow',true),(4,'Glasgow',true),(5,'Glasgow',true),(6,'Glasgow',true),(7,'Glasgow',true),(8,'Glasgow',true);
INSERT INTO swipe_events VALUES (1,1,2,'right','2026-01-01'),(2,1,3,'right','2026-01-02'),(3,3,1,'right','2026-01-03'),(4,1,4,'left','2026-01-04'),(5,1,5,'right','2026-01-05'),(6,5,1,'right','2026-01-06'),(7,1,6,'right','2026-01-07'),(8,6,1,'right','2026-01-08'),(9,1,7,'right','2026-01-09'),(10,7,1,'right','2026-01-10'),(11,1,2,'right','2026-01-11');
INSERT INTO matches VALUES (301,1,3,'2026-01-03',NULL),(302,1,7,'2026-01-10','2026-01-12');
INSERT INTO block_edges VALUES (1,5);
INSERT INTO report_events VALUES (1,1,6);
