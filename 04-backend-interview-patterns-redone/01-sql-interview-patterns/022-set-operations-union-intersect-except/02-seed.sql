SET search_path TO bip_sql_022;
INSERT INTO creators VALUES (101,'Ana',true),(102,'Ben',true),(103,'Cy',true),(104,'Diya',true),(105,'Eli',true),(106,'Faye',false);
INSERT INTO posts VALUES (1,101,'published',true),(2,101,'published',true),(3,101,'published',true),(4,102,'published',true),(5,102,'published',true),(6,102,'published',true),(7,103,'published',true),(8,103,'published',true),(9,103,'published',true),(10,104,'published',true),(11,104,'published',true),(12,104,'published',true),(13,105,'published',true),(14,105,'published',false),(15,105,'draft',true),(16,106,'published',true),(17,106,'published',true),(18,106,'published',true);
INSERT INTO payout_onboarding VALUES (101,true),(103,true),(104,true),(105,true),(106,true);
INSERT INTO policy_violations VALUES (103,true);
INSERT INTO fraud_investigations VALUES (104,true);
