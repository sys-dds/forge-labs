SET search_path TO bip_sql_002;
INSERT INTO users VALUES (201,'Iris',true),(202,'Jon',true),(203,'Kara',true),(204,'Mina',false),(205,'Niko',true);
INSERT INTO required_checks VALUES ('identity'),('address'),('tax');
INSERT INTO user_checks VALUES (201,'identity','passed'),(201,'address','passed'),(201,'tax','passed'),(202,'identity','passed'),(202,'address','passed'),(203,'identity','failed'),(203,'address','passed'),(203,'tax','passed'),(204,'identity','failed'),(205,'identity','passed');
