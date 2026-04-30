SET search_path TO bip_pim_004;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya');
INSERT INTO posts VALUES (401,1,'Modeling post');
INSERT INTO post_reactions VALUES (1,401,2,'like',true,'2026-01-01'),(2,401,3,'like',true,'2026-01-02'),(3,401,3,'like',false,'2026-01-03'),(4,401,4,'like',true,'2026-01-04');
INSERT INTO comments VALUES (501,401,2,NULL,'Visible comment',NULL),(502,401,3,NULL,'Deleted comment','2026-01-05'),(503,401,4,501,'Visible reply',NULL),(504,401,3,502,'Reply under deleted parent',NULL);
