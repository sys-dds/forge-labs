SET search_path TO bip_pim_030;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'); INSERT INTO conversations VALUES (101,'direct'),(102,'group'); INSERT INTO conversation_participants VALUES (201,101,1,'active'),(202,101,2,'active'),(203,102,1,'active'),(204,102,3,'active');
INSERT INTO messages VALUES (1001,101,2,1,50,'hello'),(1002,101,1,2,60,'draft'),(1003,101,2,3,70,'delete me'),(1004,102,3,1,80,'bad msg');
INSERT INTO message_delivery_states VALUES (2001,1001,1,'read'),(2002,1002,2,'delivered'),(2003,1004,1,'delivered'); INSERT INTO message_read_receipts VALUES (2101,101,1,1),(2102,101,2,1),(2103,102,1,0);
INSERT INTO message_edits VALUES (2201,1002,'edited body',1); INSERT INTO message_deletions VALUES (2301,1003,'for_me',1); INSERT INTO message_attachments VALUES (3001,1002,'note.png');
INSERT INTO conversation_user_settings VALUES (4001,101,1,false,false),(4002,102,1,true,false); INSERT INTO block_edges VALUES (1,3); INSERT INTO message_reports VALUES (7001,1004,1,'abuse'); INSERT INTO review_queue_items VALUES (8001,1004,'review');
