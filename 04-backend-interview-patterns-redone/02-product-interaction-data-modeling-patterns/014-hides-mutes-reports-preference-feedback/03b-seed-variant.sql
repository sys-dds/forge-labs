SET search_path TO bip_pim_014;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya');
INSERT INTO posts VALUES (301,2,'Ben no longer hidden',NULL),(302,3,'Cy muted by Ada',NULL),(303,4,'Diya reported by Ada',NULL),(304,2,'Ben normal',NULL);
INSERT INTO follow_edges VALUES (1,2,'active'),(1,3,'active'),(1,4,'active'),(2,4,'active');
INSERT INTO mute_edges VALUES (1,3,'active');
INSERT INTO report_events VALUES (801,1,303,'spam','2026-04-11 09:05'),(802,2,303,'abuse','2026-04-11 09:06');
INSERT INTO preference_feedback_events VALUES (901,1,302,'less_like_this','2026-04-11 09:10'),(902,1,304,'more_like_this','2026-04-11 09:15');
INSERT INTO review_queue_candidates VALUES (1001,303,801,'open'),(1002,303,802,'open');
