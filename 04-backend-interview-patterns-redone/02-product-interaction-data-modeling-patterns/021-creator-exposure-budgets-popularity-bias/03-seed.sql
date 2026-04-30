SET search_path TO bip_pim_021;
INSERT INTO creators VALUES (1,'MegaMaker',980),(2,'QuietCraft',120),(3,'LowLift',80),(4,'RepeatRay',300);
INSERT INTO creator_profiles VALUES (1,'active'),(2,'active'),(3,'active'),(4,'active');
INSERT INTO creator_content VALUES (101,1,'mega lesson','active'),(102,2,'quiet guide','active'),(103,3,'thin tip','active'),(104,4,'repeat clip','active');
INSERT INTO exposure_budget_windows VALUES (201,1,'home',3),(202,2,'home',3),(203,3,'home',3),(204,4,'home',3);
INSERT INTO exposure_events VALUES (301,1,41,'home'),(302,1,42,'home'),(303,1,43,'home'),(304,2,44,'home'),(305,4,45,'home');
INSERT INTO creator_quality_components VALUES (401,1,'completion',60),(402,1,'rating',30),(403,2,'completion',40),(404,2,'rating',30),(405,3,'completion',20),(406,3,'rating',10),(407,4,'completion',50),(408,4,'rating',30);
INSERT INTO viewer_seen_events VALUES (501,10,4);
INSERT INTO creator_surface_candidates VALUES (601,10,1,'popular'),(602,10,2,'long_tail'),(603,10,3,'long_tail'),(604,10,4,'fresh');
