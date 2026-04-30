SET search_path TO bip_sql_022;
INSERT INTO creators VALUES (201,'Iris',true),(202,'Jon',true),(203,'Kara',true),(204,'Mina',true),(205,'Niko',false);
INSERT INTO posts VALUES (1,201,'published',true),(2,201,'published',true),(3,201,'published',true),(4,202,'published',true),(5,202,'published',true),(6,202,'published',true),(7,203,'published',true),(8,203,'published',true),(9,203,'published',true),(10,204,'published',true),(11,204,'published',true),(12,204,'published',false),(13,205,'published',true),(14,205,'published',true),(15,205,'published',true);
INSERT INTO payout_onboarding VALUES (201,true),(202,true),(203,true),(204,true),(205,true);
INSERT INTO policy_violations VALUES (202,true);
INSERT INTO fraud_investigations VALUES (203,false);
