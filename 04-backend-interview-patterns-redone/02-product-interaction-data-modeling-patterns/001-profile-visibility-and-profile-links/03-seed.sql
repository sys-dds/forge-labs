SET search_path TO bip_pim_001;
INSERT INTO users VALUES (1,'Ada',true),(2,'Ben',true),(3,'Omar',true),(4,'Diya',false);
INSERT INTO profiles VALUES (101,1,'ada_dev'),(102,2,'ben_ops'),(103,4,'diya_data');
INSERT INTO profile_field_visibility VALUES (101,'bio','Backend engineer','public'),(101,'email','ada@example.com','private'),(102,'bio','Ops builder','public'),(102,'email','ben@example.com','private'),(103,'bio','Inactive profile','public');
INSERT INTO user_blocks VALUES (1,3,'2026-01-01 09:00');
