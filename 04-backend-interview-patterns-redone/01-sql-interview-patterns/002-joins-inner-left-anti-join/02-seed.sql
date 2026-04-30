SET search_path TO bip_sql_002;
INSERT INTO users VALUES (101,'Ada',true),(102,'Ben',true),(103,'Cy',true),(104,'Diya',true),(105,'Noor',false);
INSERT INTO required_checks VALUES ('identity'),('address');
INSERT INTO user_checks VALUES (101,'identity','passed'),(101,'address','passed'),(102,'identity','passed'),(103,'identity','failed'),(103,'address','passed'),(105,'identity','failed');
