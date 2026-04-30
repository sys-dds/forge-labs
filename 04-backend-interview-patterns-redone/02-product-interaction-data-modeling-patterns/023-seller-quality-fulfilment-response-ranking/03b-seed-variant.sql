SET search_path TO bip_pim_023;
INSERT INTO sellers VALUES (1,'BrightSeller'),(2,'RiskSeller');
INSERT INTO listings VALUES (101,1,'active'),(102,2,'active');
INSERT INTO orders VALUES (201,1,'completed'),(202,1,'completed'),(203,2,'completed');
INSERT INTO seller_response_events VALUES (301,1,8),(302,2,30);
INSERT INTO seller_reviews VALUES (401,1,5),(402,2,4);
INSERT INTO disputes VALUES (501,2,'resolved');
INSERT INTO seller_quality_components VALUES (601,1,'fulfilment',50),(602,1,'cancellation',0),(603,1,'dispute',0),(604,1,'response_time',20),(605,1,'review',25),(606,2,'fulfilment',35),(607,2,'cancellation',0),(608,2,'dispute',0),(609,2,'response_time',15),(610,2,'review',20);
INSERT INTO seller_quality_snapshots VALUES (701,1,95,'boost'),(702,2,70,'allow');
