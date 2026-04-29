-- Capstone: ordered candidate rows with raw score inputs.
CREATE VIEW window_ranking_capstone AS SELECT * FROM feed_ranking_inputs ORDER BY created_at DESC, post_id DESC;
