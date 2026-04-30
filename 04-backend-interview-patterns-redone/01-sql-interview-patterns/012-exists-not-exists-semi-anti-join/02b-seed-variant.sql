SET search_path TO bip_sql_012;
INSERT INTO buyers VALUES (201,'Iris',true),(202,'Jon',true),(203,'Kara',true),(204,'Mina',true);
INSERT INTO payment_methods VALUES (101,201,true),(102,202,true),(103,203,false),(104,204,true);
INSERT INTO identity_checks VALUES (101,201,'passed'),(102,202,'passed'),(103,203,'passed'),(104,204,'failed');
INSERT INTO fraud_cases VALUES (101,202,'closed');
INSERT INTO chargebacks VALUES (101,202,'2025-10-01');
