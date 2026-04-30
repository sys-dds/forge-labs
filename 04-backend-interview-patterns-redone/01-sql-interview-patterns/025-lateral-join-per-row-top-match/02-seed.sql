SET search_path TO bip_sql_025;
INSERT INTO buyer_intents VALUES (1,'Glasgow','plumbing',8000),(2,'Glasgow','electrical',7000),(3,'Edinburgh','plumbing',6000),(4,'Dundee','cleaning',5000);
INSERT INTO sellers VALUES (10,'Ben',false,92),(11,'Omar',true,99),(12,'Diya',false,86),(13,'Maya',false,88);
INSERT INTO listings VALUES (101,10,'Glasgow','plumbing','active',7500,3.0),(102,12,'Glasgow','plumbing','active',7600,1.0),(103,11,'Glasgow','electrical','active',5000,1.0),(104,12,'Glasgow','electrical','active',6500,4.0),(105,13,'Edinburgh','plumbing','active',6500,2.0),(106,10,'Edinburgh','plumbing','inactive',5500,1.0),(107,12,'Aberdeen','cleaning','active',4000,1.0);
