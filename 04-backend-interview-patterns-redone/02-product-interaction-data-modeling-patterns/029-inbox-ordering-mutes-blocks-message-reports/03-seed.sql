SET search_path TO bip_pim_029;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'); INSERT INTO conversations VALUES (101,'direct'),(102,'group'),(103,'direct'),(104,'direct'); INSERT INTO conversation_participants VALUES (201,101,1,'active'),(202,101,2,'active'),(203,102,1,'active'),(204,102,3,'active'),(205,103,1,'active'),(206,103,2,'active'),(207,104,1,'active'),(208,104,2,'active');
INSERT INTO messages VALUES (1001,101,2,1,50,'muted hello'),(1002,104,2,1,60,'tie high id'),(1003,102,3,1,70,'blocked cy'),(1004,104,2,2,60,'reported tie'),(1005,103,2,1,90,'archived latest');
INSERT INTO message_read_receipts VALUES (3001,101,1,0),(3002,104,1,1),(3003,102,1,0),(3004,103,1,0);
INSERT INTO conversation_user_settings VALUES (4001,101,1,true,false),(4002,102,1,false,false),(4003,103,1,false,true),(4004,104,1,false,false);
INSERT INTO block_edges VALUES (1,3); INSERT INTO message_reports VALUES (7001,1004,1,'harassment'); INSERT INTO review_queue_items VALUES (8001,1004,'review');
