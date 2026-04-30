SET search_path TO bip_pim_021;
CREATE TABLE creators (creator_id int PRIMARY KEY, display_name text NOT NULL, popularity int NOT NULL);
CREATE TABLE creator_profiles (creator_id int PRIMARY KEY REFERENCES creators, status text NOT NULL);
CREATE TABLE creator_content (content_id int PRIMARY KEY, creator_id int REFERENCES creators, title text NOT NULL, status text NOT NULL);
CREATE TABLE exposure_budget_windows (window_id int PRIMARY KEY, creator_id int REFERENCES creators, surface text NOT NULL, budget_limit int NOT NULL);
CREATE TABLE exposure_events (event_id int PRIMARY KEY, creator_id int REFERENCES creators, viewer_id int NOT NULL, surface text NOT NULL);
CREATE TABLE creator_quality_components (component_id int PRIMARY KEY, creator_id int REFERENCES creators, component_type text NOT NULL, component_value int NOT NULL);
CREATE TABLE viewer_seen_events (seen_id int PRIMARY KEY, viewer_id int NOT NULL, creator_id int REFERENCES creators);
CREATE TABLE creator_surface_candidates (candidate_id int PRIMARY KEY, viewer_id int NOT NULL, creator_id int REFERENCES creators, source_label text NOT NULL);
