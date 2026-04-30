SET search_path TO bip_pim_007;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Eli');
INSERT INTO posts VALUES (201,1,'Ada launch'),(202,2,'Ben note');
INSERT INTO comments VALUES (301,201,3,'Cy comments'),(302,201,1,'Ada self comment');
INSERT INTO matches VALUES (401,1,4,'2026-04-04 12:00');
INSERT INTO interaction_events VALUES (1001,2,'liked','post',201,'2026-04-04 09:00'),(1002,3,'commented','comment',301,'2026-04-04 09:10'),(1003,5,'followed','user',1,'2026-04-04 09:20'),(1004,4,'matched','match',401,'2026-04-04 09:30'),(1005,1,'liked','post',201,'2026-04-04 09:40'),(1006,2,'liked','post',201,'2026-04-04 09:50'),(1007,3,'liked','post',201,'2026-04-04 10:00');
INSERT INTO notifications VALUES (9001,1,2,'liked','post',201,1001,'2026-04-04 09:00','liked:post:201:actor:2'),(9002,1,3,'commented','post',201,1002,'2026-04-04 09:10','commented:post:201:actor:3'),(9003,1,5,'followed','user',1,1003,'2026-04-04 09:20','followed:user:1:actor:5'),(9004,1,4,'matched','match',401,1004,'2026-04-04 09:30','matched:match:401:user:1'),(9005,4,1,'matched','match',401,1004,'2026-04-04 09:30','matched:match:401:user:4'),(9006,1,3,'liked','post',201,1007,'2026-04-04 10:00','liked:post:201:actor:3');
INSERT INTO notification_state VALUES (9001,'read','2026-04-04 10:00'),(9002,'unread','2026-04-04 09:10'),(9003,'unread','2026-04-04 09:20'),(9004,'unread','2026-04-04 09:30'),(9005,'unread','2026-04-04 09:30'),(9006,'unread','2026-04-04 10:00');
