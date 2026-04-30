SET search_path TO bip_pim_039;
WITH raw_saved AS (SELECT * FROM saved_items WHERE user_id=1), checks AS (
SELECT 'private_collection_owner_visible' contract_name,'collection:3001' subject_id,'true' observed_value,'Broken assumes user saves are visible' expected_reason
UNION ALL SELECT 'private_collection_non_member_hidden','collection:3001','false','Broken ignores collection visibility'
UNION ALL SELECT 'public_collection_visible','collection:3002','false','Broken only knows saved_items'
UNION ALL SELECT 'duplicate_item_prevented','item:5003','false','Broken ignores collection item lifecycle'
UNION ALL SELECT 'collection_item_order','collection:3001',string_agg(saved_item_id::text,'>' ORDER BY saved_item_id),'Broken orders saved_items, not collection_items' FROM raw_saved
UNION ALL SELECT 'deleted_item_hidden','item:5005','false','Broken ignores deleted content'
UNION ALL SELECT 'blocked_author_item_hidden','item:5004','false','Broken ignores blocks and treatments'
UNION ALL SELECT 'collaborative_member_add_allowed','member:4001','false','Broken has no collaborator model')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
