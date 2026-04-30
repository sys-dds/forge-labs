SET search_path TO bip_pim_014;
WITH globally_visible AS (SELECT p.post_id FROM posts p LEFT JOIN hide_events h ON h.post_id=p.post_id LEFT JOIN report_events r ON r.post_id=p.post_id WHERE p.removed_at IS NULL AND h.event_id IS NULL AND r.report_id IS NULL), anchor AS (SELECT count(*) AS row_count FROM posts), checks AS (
  SELECT 'hidden_post_suppressed' contract_name, 'viewer:1 post:301' subject_id, count(*)::text observed_value, 'Broken hide acts as global deletion' expected_reason FROM globally_visible WHERE post_id=301
  UNION ALL SELECT 'muted_author_suppressed','viewer:1 author:3',count(*)::text,'Broken ignores mute edges' FROM globally_visible WHERE post_id=302
  UNION ALL SELECT 'report_review_candidate','post:303',(SELECT count(*)::text FROM report_events WHERE post_id=303),'Broken looks at raw reports instead of queue state' FROM anchor
  UNION ALL SELECT 'report_not_global_delete','viewer:2 post:303',count(*)::text,'Broken report removes content for everyone' FROM globally_visible WHERE post_id=303
  UNION ALL SELECT 'negative_feedback_signal','viewer:1',(SELECT count(*)::text FROM preference_feedback_events WHERE feedback='less_like_this'),'Broken counts feedback globally' FROM anchor
  UNION ALL SELECT 'positive_feedback_signal','viewer:1',(SELECT count(*)::text FROM preference_feedback_events WHERE feedback='more_like_this'),'Broken counts feedback globally' FROM anchor
  UNION ALL SELECT 'other_viewer_still_visible','viewer:2 post:303',count(*)::text,'Broken hides reported content globally' FROM globally_visible WHERE post_id=303
  UNION ALL SELECT 'viewer_specific_controls','viewer:1',COALESCE(string_agg(post_id::text,'|' ORDER BY post_id),'none'),'Broken uses one global feed for every viewer' FROM globally_visible
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
