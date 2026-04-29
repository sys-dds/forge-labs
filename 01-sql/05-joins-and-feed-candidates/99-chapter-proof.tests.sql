DO $$
DECLARE
  ids text;
  c integer;
BEGIN
  SELECT string_agg(post_id::text, ',' ORDER BY post_id) INTO ids FROM feed_candidates;
  IF ids <> '1,4' THEN RAISE EXCEPTION 'expected exact feed candidate post ids 1,4 got %', ids; END IF;

  SELECT count(*) INTO c FROM feed_candidates WHERE handle IN ('linus','margaret');
  IF c <> 0 THEN RAISE EXCEPTION 'muted or blocked author appeared in feed candidates'; END IF;

  SELECT count(*) INTO c FROM feed_candidates WHERE display_name IS NULL OR viewer_follows_author IS DISTINCT FROM true;
  IF c <> 0 THEN RAISE EXCEPTION 'candidate missing author profile or relationship metadata'; END IF;

  SELECT count(*) INTO c FROM row_multiplication_bad;
  IF c <> 4 THEN RAISE EXCEPTION 'bad multiplication example should produce four rows, got %', c; END IF;

  SELECT like_count INTO c FROM row_multiplication_fixed;
  IF c <> 2 THEN RAISE EXCEPTION 'fixed like count wrong: %', c; END IF;
  SELECT comment_count INTO c FROM row_multiplication_fixed;
  IF c <> 2 THEN RAISE EXCEPTION 'fixed comment count wrong: %', c; END IF;
END $$;
