SET search_path TO bip_pim_033;
INSERT INTO users VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Eli');
INSERT INTO communities VALUES (101,'Workshop Circle','private');
INSERT INTO community_memberships VALUES (3001,101,1,'active'),(3002,101,2,'active'),(3003,101,3,'active'),(3004,101,4,'removed'),(3005,101,5,'banned');
INSERT INTO community_channels VALUES (201,101,'announcements','public'),(202,101,'organizers','private');
INSERT INTO channel_memberships VALUES (5002,202,2,'active');
INSERT INTO community_posts VALUES (1001,101,201,1,'Pinned welcome','active',true,10),(1002,101,202,2,'Organizer note','active',false,20),(1003,101,201,2,'Reply to welcome','active',false,30),(1004,101,201,1,'Deleted draft','deleted',false,40),(1005,101,201,3,'Removed spam','active',false,50);
INSERT INTO community_threads VALUES (6001,101,1001,1003);
INSERT INTO community_post_moderation_actions VALUES (7001,1005,2,'remove','spam report');
