SET search_path TO bip_pim_003;
INSERT INTO users VALUES (1,'Ada',true),(2,'Ben',true),(3,'Cy',true),(4,'Diya',true),(5,'Omar',true),(6,'Lina',true),(7,'Maya',true);
INSERT INTO friend_requests VALUES (1,1,2,'accepted'),(2,1,3,'accepted'),(3,4,1,'cancelled'),(4,5,1,'accepted');
INSERT INTO friendships VALUES (1,2,'2026-01-01'),(1,6,'2026-01-02'),(2,6,'2026-01-03'),(1,7,'2026-01-04'),(2,7,'2026-01-05'),(1,3,'2026-01-06');
INSERT INTO block_edges VALUES (1,5);
