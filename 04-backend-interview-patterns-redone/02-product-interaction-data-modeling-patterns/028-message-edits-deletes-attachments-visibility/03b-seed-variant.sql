SET search_path TO bip_pim_028;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'); INSERT INTO conversations VALUES (101,'direct'); INSERT INTO conversation_participants VALUES (201,101,1),(202,101,2);
INSERT INTO messages VALUES (1001,101,1,'first body'),(1002,101,2,'private delete'),(1003,101,1,'global delete'),(1004,101,2,'attachment stays');
INSERT INTO message_edits VALUES (2001,1001,'second body',1),(2002,1001,'final body',2),(2003,1001,'variant final body',3);
INSERT INTO message_deletions VALUES (2501,1002,1,'for_me',1);
INSERT INTO message_attachments VALUES (3001,1004,'photo.png'),(3002,1003,'hidden.pdf');
