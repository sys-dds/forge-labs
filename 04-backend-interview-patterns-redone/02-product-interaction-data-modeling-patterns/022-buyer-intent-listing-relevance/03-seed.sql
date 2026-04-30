SET search_path TO bip_pim_022;
INSERT INTO buyers VALUES (10,'Ada');
INSERT INTO buyer_intents VALUES (201,10,'cleaning',120,'North');
INSERT INTO sellers VALUES (1,'SparkSeller','active'),(2,'SeenSeller','active'),(3,'RiskSeller','active'),(4,'TutorSeller','active');
INSERT INTO listings VALUES (101,1,'Deep clean','cleaning',95,'North','active',4),(102,2,'Quick clean','cleaning',80,'North','active',5),(103,3,'Cheap clean','cleaning',60,'North','active',6),(104,4,'Math help','tutoring',90,'North','active',7);
INSERT INTO listing_tags VALUES (101,'insured'),(102,'fast'),(103,'cheap'),(104,'math');
INSERT INTO listing_availability VALUES (301,101,'available'),(302,102,'available'),(303,103,'available'),(304,104,'available');
INSERT INTO seller_trust_components VALUES (401,1,'fulfilment',45),(402,1,'review',35),(403,2,'fulfilment',40),(404,2,'review',30),(405,3,'fulfilment',15),(406,3,'review',10),(407,4,'fulfilment',45),(408,4,'review',35);
INSERT INTO buyer_seen_listings VALUES (501,10,102);
