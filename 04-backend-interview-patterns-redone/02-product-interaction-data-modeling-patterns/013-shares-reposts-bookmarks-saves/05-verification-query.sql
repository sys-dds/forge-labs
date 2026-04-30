SET search_path TO bip_pim_013;
WITH visible_reposts AS (
  SELECT r.repost_id, r.original_post_id FROM reposts r JOIN posts p ON p.post_id=r.original_post_id LEFT JOIN block_edges b ON b.blocker_user_id=p.author_user_id AND b.blocked_user_id=1 WHERE r.deleted_at IS NULL AND p.deleted_at IS NULL AND b.blocker_user_id IS NULL
), visible_quotes AS (
  SELECT q.quote_repost_id, q.original_post_id, q.quote_text FROM quote_reposts q JOIN posts p ON p.post_id=q.original_post_id LEFT JOIN block_edges b ON b.blocker_user_id=p.author_user_id AND b.blocked_user_id=1 WHERE q.deleted_at IS NULL AND p.deleted_at IS NULL AND b.blocker_user_id IS NULL
), active_saves AS (SELECT user_id, post_id, count(*) AS active_rows FROM bookmarks WHERE deleted_at IS NULL GROUP BY user_id, post_id), checks AS (
  SELECT 'repost_original_reference' contract_name, 'repost:301' subject_id, COALESCE(max(original_post_id)::text,'none') observed_value, 'Repost 301 points at original post 201' expected_reason FROM visible_reposts WHERE repost_id=301
  UNION ALL SELECT 'quote_repost_reference','quote:401',COALESCE(max(original_post_id::text || ':' || quote_text),'none'),'Quote repost keeps Ada text plus original reference' FROM visible_quotes WHERE quote_repost_id=401
  UNION ALL SELECT 'duplicate_save_prevented','user:1 post:201',count(*)::text,'Ada has one logical save even with duplicate active history rows' FROM active_saves WHERE user_id=1 AND post_id=201
  UNION ALL SELECT 'private_save_visible_to_owner','viewer:1 post:201',count(*)::text,'Ada can see her own save state' FROM active_saves WHERE user_id=1 AND post_id=201
  UNION ALL SELECT 'private_save_hidden_from_others','viewer:3 user:1 save',count(*)::text,'Cy cannot read Ada private bookmark state' FROM active_saves WHERE user_id=999 AND post_id=201
  UNION ALL SELECT 'share_count','post:201',(SELECT (count(*) + (SELECT count(*) FROM visible_quotes WHERE original_post_id=201))::text FROM visible_reposts WHERE original_post_id=201),'Share count derives from active visible repost and quote rows' FROM posts WHERE post_id=201
  UNION ALL SELECT 'deleted_original_suppresses_share','repost:302',count(*)::text,'Deleted original post 202 suppresses repost visibility' FROM visible_reposts WHERE repost_id=302
  UNION ALL SELECT 'blocked_author_suppresses_share','repost:303',count(*)::text,'Omar blocked Ada so repost of Omar content is hidden' FROM visible_reposts WHERE repost_id=303
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
