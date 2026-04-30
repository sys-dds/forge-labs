SET search_path TO bip_pim_013;
WITH all_reposts AS (SELECT repost_id, original_post_id FROM reposts WHERE deleted_at IS NULL), all_bookmarks AS (SELECT * FROM bookmarks), anchor AS (SELECT count(*) AS row_count FROM all_reposts), checks AS (
  SELECT 'repost_original_reference' contract_name, 'repost:301' subject_id, COALESCE(max(original_post_id)::text,'none') observed_value, 'Broken treats reposts as public rows' expected_reason FROM all_reposts WHERE repost_id=301
  UNION ALL SELECT 'quote_repost_reference','quote:401',(SELECT original_post_id::text || ':' || quote_text FROM quote_reposts WHERE quote_repost_id=401),'Broken still reads quote row' FROM anchor
  UNION ALL SELECT 'duplicate_save_prevented','user:1 post:201',(SELECT count(*)::text FROM all_bookmarks WHERE user_id=1 AND post_id=201),'Broken counts all bookmark history rows' FROM anchor
  UNION ALL SELECT 'private_save_visible_to_owner','viewer:1 post:201',(SELECT count(*)::text FROM all_bookmarks WHERE user_id=1 AND post_id=201),'Broken exposes raw bookmark rows' FROM anchor
  UNION ALL SELECT 'private_save_hidden_from_others','viewer:3 user:1 save',(SELECT count(*)::text FROM all_bookmarks WHERE user_id=1 AND post_id=201),'Broken leaks Ada saves to Cy' FROM anchor
  UNION ALL SELECT 'share_count','post:201',(SELECT count(*)::text FROM all_reposts WHERE original_post_id=201),'Broken ignores quote reposts and original visibility' FROM anchor
  UNION ALL SELECT 'deleted_original_suppresses_share','repost:302',count(*)::text,'Broken leaks repost with deleted original' FROM all_reposts WHERE repost_id=302
  UNION ALL SELECT 'blocked_author_suppresses_share','repost:303',count(*)::text,'Broken leaks blocked original author content' FROM all_reposts WHERE repost_id=303
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
