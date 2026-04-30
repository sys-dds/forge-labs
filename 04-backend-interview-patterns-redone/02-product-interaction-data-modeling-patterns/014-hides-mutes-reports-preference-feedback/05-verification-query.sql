SET search_path TO bip_pim_014;
WITH visible_for_ada AS (
  SELECT p.post_id FROM posts p JOIN follow_edges f ON f.followed_user_id=p.author_user_id AND f.follower_user_id=1 AND f.state='active' LEFT JOIN hide_events h ON h.viewer_user_id=1 AND h.post_id=p.post_id LEFT JOIN mute_edges m ON m.muter_user_id=1 AND m.muted_user_id=p.author_user_id AND m.state='active' WHERE p.removed_at IS NULL AND h.event_id IS NULL AND m.muter_user_id IS NULL
), visible_for_ben AS (
  SELECT p.post_id FROM posts p JOIN follow_edges f ON f.followed_user_id=p.author_user_id AND f.follower_user_id=2 AND f.state='active' WHERE p.removed_at IS NULL
), feedback AS (SELECT feedback, count(*) AS event_count FROM preference_feedback_events WHERE viewer_user_id=1 GROUP BY feedback), checks AS (
  SELECT 'hidden_post_suppressed' contract_name, 'viewer:1 post:301' subject_id, count(*)::text observed_value, 'Ada hide event 701 suppresses only Ada view of post 301' expected_reason FROM visible_for_ada WHERE post_id=301
  UNION ALL SELECT 'muted_author_suppressed','viewer:1 author:3',count(*)::text,'Ada mute edge suppresses Cy post 302' FROM visible_for_ada WHERE post_id=302
  UNION ALL SELECT 'report_review_candidate','post:303',count(*)::text,'Report events create open review queue candidates' FROM review_queue_candidates WHERE post_id=303 AND state='open'
  UNION ALL SELECT 'report_not_global_delete','viewer:2 post:303',count(*)::text,'Ben can still see reported post 303 because report is not deletion' FROM visible_for_ben WHERE post_id=303
  UNION ALL SELECT 'negative_feedback_signal','viewer:1',COALESCE(max(event_count)::text,'0'),'less_like_this feedback creates negative signal' FROM feedback WHERE feedback='less_like_this'
  UNION ALL SELECT 'positive_feedback_signal','viewer:1',COALESCE(max(event_count)::text,'0'),'more_like_this feedback creates positive signal' FROM feedback WHERE feedback='more_like_this'
  UNION ALL SELECT 'other_viewer_still_visible','viewer:2 post:303',count(*)::text,'Other viewers can see non-removed reported content' FROM visible_for_ben WHERE post_id=303
  UNION ALL SELECT 'viewer_specific_controls','viewer:1',COALESCE(string_agg(post_id::text,'|' ORDER BY post_id),'none'),'Ada feed keeps only rows not hidden or muted' FROM visible_for_ada
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
