INSERT INTO users VALUES (1,'ada','Ada'),(2,'ben','Ben'),(3,'cy','Cy'),(4,'noor','Noor'),(5,'diya','Diya'),(6,'maya','Maya');
INSERT INTO follows VALUES (1,2),(1,3),(1,4);
INSERT INTO mutes VALUES (1,3);
INSERT INTO blocks VALUES (1,4);
INSERT INTO posts VALUES (101,2,false,'2026-04-29 10:00'),(102,2,false,'2026-04-29 11:00'),(103,2,true,'2026-04-29 12:00'),(201,3,false,'2026-04-29 13:00'),(301,4,false,'2026-04-29 14:00'),(401,5,false,'2026-04-29 15:00');
INSERT INTO likes VALUES (101,1),(101,6),(102,1);
INSERT INTO comments VALUES (1,101),(2,101),(3,101);
