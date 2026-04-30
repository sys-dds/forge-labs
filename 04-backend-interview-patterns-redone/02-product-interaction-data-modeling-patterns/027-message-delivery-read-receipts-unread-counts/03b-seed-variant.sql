SET search_path TO bip_pim_027;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'); INSERT INTO conversations VALUES (101,'group'); INSERT INTO conversation_participants VALUES (201,101,1,'active'),(202,101,2,'active'),(203,101,3,'active');
INSERT INTO messages VALUES (1001,101,1,1,'one'),(1002,101,2,2,'two'),(1003,101,1,3,'three'),(1004,101,3,4,'four');
INSERT INTO message_delivery_states VALUES (3001,1001,2,'read'),(3002,1001,3,'read'),(3003,1002,1,'read'),(3004,1003,2,'delivered'),(3005,1004,1,'delivered');
INSERT INTO message_read_receipts VALUES (4001,101,2,3),(4002,101,1,2),(4003,101,3,3);
