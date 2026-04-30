DO $$ BEGIN
IF (SELECT count(*) FROM matching_windows) <> 1 THEN RAISE EXCEPTION 'range overlap wrong'; END IF;
IF NOT EXISTS (SELECT 1 FROM service_listings WHERE id=1 AND tags @> ARRAY['bicycle'] AND search_label='ben-bicycle-repair') THEN RAISE EXCEPTION 'array or generated label wrong'; END IF;
BEGIN INSERT INTO service_listings(id,seller,title,status,tags,availability) VALUES (3,'ada','Bad','published',ARRAY['bad'],tstzrange('2026-01-01','2026-01-02')); RAISE EXCEPTION 'invalid enum accepted'; EXCEPTION WHEN invalid_text_representation THEN NULL; END;
END $$;