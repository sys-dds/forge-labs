SET search_path TO bip_pim_002;
INSERT INTO users VALUES (1,'Ada',true),(2,'Ben',true),(3,'Cy',true),(4,'Omar',true);
INSERT INTO follow_edges VALUES (1,2,'active','2026-01-01'),(3,2,'inactive','2026-01-02'),(4,2,'active','2026-01-03'),(2,3,'active','2026-01-04');
INSERT INTO block_edges VALUES (2,4,'2026-01-05');
INSERT INTO posts VALUES (201,2,'Ben post'),(202,3,'Cy post');
