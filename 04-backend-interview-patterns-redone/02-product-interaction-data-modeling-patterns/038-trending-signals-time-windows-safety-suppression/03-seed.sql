SET search_path TO bip_pim_038;
INSERT INTO topics VALUES (101,'Build Systems'),(102,'Giveaway Spam'),(103,'Old Launch');
INSERT INTO posts VALUES (201,101,'active'),(202,102,'active'),(203,103,'active');
INSERT INTO trend_windows VALUES (3001,'2026-04-29 00:00','2026-04-30 00:00','last_24h');
INSERT INTO interaction_events VALUES (10001,101,201,1,'view','2026-04-29 10:00'),(10002,101,201,2,'save','2026-04-29 10:05'),(10003,101,201,3,'share','2026-04-29 10:06'),(10004,102,202,9,'view','2026-04-29 11:00'),(10005,102,202,9,'view','2026-04-29 11:01'),(10006,102,202,9,'view','2026-04-29 11:02'),(10007,103,203,4,'view','2026-04-10 11:00');
INSERT INTO trend_signal_components VALUES (4001,3001,101,'velocity',30),(4002,3001,101,'unique_actor',20),(4003,3001,101,'freshness',10),(4004,3001,102,'velocity',50),(4005,3001,102,'unique_actor',2),(4006,3001,102,'freshness',8),(4007,3001,103,'velocity',12),(4008,3001,103,'unique_actor',8),(4009,3001,103,'freshness',-15);
INSERT INTO abuse_signal_events VALUES (6001,102,'coordinated_spam',5);
INSERT INTO policy_treatments VALUES (7001,102,'hide','spam cluster'),(7002,103,'downrank','old activity');
INSERT INTO trend_snapshots VALUES (8001,3001,101,60,'active'),(8002,3001,102,60,'suppressed'),(8003,3001,103,5,'decayed');
