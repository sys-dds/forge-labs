SET search_path TO bip_sql_025;
INSERT INTO buyer_intents VALUES (5,'Glasgow','plumbing',8000),(6,'Glasgow','electrical',7000),(7,'Edinburgh','plumbing',6000),(8,'Dundee','cleaning',5000);
INSERT INTO sellers VALUES (20,'Iris',false,91),(21,'Jon',true,99),(22,'Kara',false,87),(23,'Mina',false,95);
INSERT INTO listings VALUES (201,20,'Glasgow','plumbing','active',7500,3.0),(202,22,'Glasgow','plumbing','active',7600,1.0),(203,23,'Glasgow','plumbing','active',7800,2.0),(204,21,'Glasgow','electrical','active',5000,1.0),(205,22,'Glasgow','electrical','active',6500,4.0),(206,23,'Edinburgh','plumbing','active',5900,5.0),(207,22,'Dundee','cleaning','inactive',4000,1.0);
