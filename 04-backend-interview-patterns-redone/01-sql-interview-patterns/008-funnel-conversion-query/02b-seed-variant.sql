SET search_path TO bip_sql_008;
INSERT INTO funnel_steps VALUES ('viewed',1),('contacted',2),('booked',3),('completed',4);
INSERT INTO funnel_events VALUES
(6001,201,'viewed','2026-02-01 09:00'),(6002,201,'contacted','2026-02-01 09:05'),(6003,201,'booked','2026-02-01 09:10'),(6004,201,'completed','2026-02-02 09:00'),
(7001,202,'viewed','2026-02-01 10:00'),(7002,202,'contacted','2026-02-01 10:05'),
(8001,203,'viewed','2026-02-01 11:00'),(8002,203,'contacted','2026-02-01 11:05'),(8003,203,'completed','2026-02-02 11:00'),
(9001,204,'booked','2026-02-01 12:00'),(9002,204,'viewed','2026-02-01 12:05'),(9003,204,'contacted','2026-02-01 12:10');
