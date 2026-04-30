SET search_path TO bip_pim_034;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Eli');
INSERT INTO communities VALUES (101,'Event Guild','private');
INSERT INTO community_memberships VALUES (1001,101,1,'active'),(1002,101,2,'active'),(1004,101,4,'active'),(1005,101,5,'active');
INSERT INTO community_events VALUES (2001,101,'Schema Night','scheduled',true,3,'2026-05-10'),(2002,101,'Cancelled Demo','cancelled',true,10,'2026-05-11');
INSERT INTO event_rsvps VALUES (3001,2001,1,'going','2026-04-01'),(3002,2001,2,'going','2026-04-02'),(3003,2001,3,'going','2026-04-03'),(3004,2001,4,'declined','2026-04-04'),(3005,2001,5,'going','2026-04-09'),(3006,2002,1,'going','2026-04-06');
INSERT INTO event_waitlist VALUES (4005,2001,5,1,'promoted');
INSERT INTO event_attendance VALUES (5001,2001,1,3001,'2026-05-10');
INSERT INTO event_audit_log VALUES (6001,2001,2,'promote_waitlist',5,'2026-04-07'),(6002,2002,1,'cancel',NULL,'2026-04-08'),(6003,2001,1,'check_in',1,'2026-05-10');
