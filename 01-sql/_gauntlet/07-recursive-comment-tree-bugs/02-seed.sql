INSERT INTO posts VALUES (100),(200);
INSERT INTO comments VALUES
  (1,100,null,'c1 root'),(2,100,1,'c2 reply'),(3,100,1,'c3 reply'),(4,100,2,'c4 nested'),(5,100,4,'c5 deep'),
  (6,200,null,'c6 other root'),(7,200,6,'c7 other reply');
