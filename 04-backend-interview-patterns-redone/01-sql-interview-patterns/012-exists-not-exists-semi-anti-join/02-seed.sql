SET search_path TO bip_sql_012;
INSERT INTO buyers VALUES (101,'Ada',true),(102,'Ben',true),(103,'Cy',true),(104,'Diya',true),(105,'Omar',true),(106,'Noor',true),(107,'Lina',false);
INSERT INTO payment_methods VALUES (1,101,true),(2,101,true),(3,102,false),(4,103,true),(5,104,true),(6,105,true),(7,106,true),(8,107,true);
INSERT INTO identity_checks VALUES (1,101,'passed'),(2,102,'passed'),(3,103,'failed'),(4,104,'passed'),(5,105,'passed'),(6,106,'passed'),(7,107,'passed');
INSERT INTO fraud_cases VALUES (1,106,'open'),(2,104,'closed');
INSERT INTO chargebacks VALUES (1,104,'2025-09-01'),(2,105,'2026-01-15');
