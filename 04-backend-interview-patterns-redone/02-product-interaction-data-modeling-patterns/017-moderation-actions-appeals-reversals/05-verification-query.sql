SET search_path TO bip_pim_017;
WITH current_actions AS (SELECT DISTINCT ON (post_id) post_id, treatment, action_id, actor_moderator_id FROM moderation_actions ORDER BY post_id, created_at DESC, action_id DESC), history AS (SELECT post_id, string_agg(treatment,'>' ORDER BY created_at, action_id) AS treatments FROM moderation_actions GROUP BY post_id), checks AS (
  SELECT 'removed_content_hidden' contract_name, 'post:201' subject_id, count(*)::text observed_value, 'Post 201 is hidden while latest action is remove' expected_reason FROM current_actions WHERE post_id=201 AND treatment='remove'
  UNION ALL SELECT 'pending_appeal_no_restore','appeal:701',count(*)::text,'Pending appeal 701 does not restore post 201' FROM appeals a JOIN current_actions ca ON ca.post_id=a.post_id WHERE a.appeal_id=701 AND a.state='pending' AND ca.treatment='remove'
  UNION ALL SELECT 'approved_appeal_restored','appeal:702',count(*)::text,'Approved appeal 702 restores post 202' FROM appeals a JOIN current_actions ca ON ca.post_id=a.post_id WHERE a.appeal_id=702 AND a.state='approved' AND ca.treatment='restore'
  UNION ALL SELECT 'rejected_appeal_still_removed','appeal:703',count(*)::text,'Rejected appeal 703 keeps post 203 removed' FROM appeals a JOIN current_actions ca ON ca.post_id=a.post_id WHERE a.appeal_id=703 AND a.state='rejected' AND ca.treatment='remove'
  UNION ALL SELECT 'reversal_audit_logged','post:202',count(*)::text,'Audit row 9002 records remove to restore reversal' FROM audit_log WHERE entity_id=202 AND action='appeal_restore' AND previous_treatment='remove' AND new_treatment='restore'
  UNION ALL SELECT 'current_treatment','post:202',max(treatment),'Current treatment differs after approved appeal' FROM current_actions WHERE post_id=202
  UNION ALL SELECT 'historical_treatment','post:202',max(treatments),'History preserves remove then restore' FROM history WHERE post_id=202
  UNION ALL SELECT 'actor_lineage','post:202',string_agg(actor_type||':'||actor_id||':'||action,'|' ORDER BY audit_id),'Audit lineage traces moderator/operator actors' FROM audit_log WHERE entity_id=202
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
