INSERT INTO users VALUES (1,'ada'),(2,'ben'),(3,'cy'),(4,'noor'),(5,'diya'),(6,'maya'),(7,'omar');
INSERT INTO follows VALUES (1,2),(1,3),(1,4);
INSERT INTO mutes VALUES (1,3);
INSERT INTO blocks VALUES (1,4);
INSERT INTO posts VALUES
  (101,2,'Ben post with two likes and three comments'),
  (102,2,'Ben quiet post with zero comments'),
  (201,3,'Cy muted post'),
  (301,4,'Noor blocked post'),
  (401,5,'Diya unfollowed post');
INSERT INTO likes VALUES (101,1),(101,6),(102,1);
INSERT INTO comments VALUES (1001,101,1,'Ada'),(1002,101,6,'Maya'),(1003,101,7,'Omar');
