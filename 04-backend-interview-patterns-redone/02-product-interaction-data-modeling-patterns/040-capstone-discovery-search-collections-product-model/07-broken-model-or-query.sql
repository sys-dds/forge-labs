SET search_path TO bip_pim_040;
WITH popular AS (SELECT post_id FROM posts WHERE content_state='active'), checks AS (
SELECT 'topic_discovery_contract' contract_name,'topic:101' subject_id,(SELECT string_agg(post_id::text,'|' ORDER BY post_id) FROM popular) observed_value,'Broken returns globally popular active posts' expected_reason
UNION ALL SELECT 'search_result_contract','query:9001',(SELECT string_agg(post_id::text,'|' ORDER BY post_id) FROM popular),'Broken ignores query filters and facets'
UNION ALL SELECT 'filter_facet_contract','facet:9151','filters=none|facet=all','Broken ignores filter/facet rows'
UNION ALL SELECT 'saved_search_contract','saved:9202','false','Broken alerts paused saved search'
UNION ALL SELECT 'trending_component_contract','window:11001',(SELECT count(*)::text FROM interaction_events),'Broken uses raw popularity count'
UNION ALL SELECT 'safety_suppression_contract','topic:102','false','Broken ignores safety suppression'
UNION ALL SELECT 'collection_visibility_contract','collection:12001','true','Broken assumes all collections visible'
UNION ALL SELECT 'collection_item_lifecycle_contract','collection:12001',(SELECT string_agg(item_id::text,'>' ORDER BY item_id) FROM collection_items WHERE collection_id=12001),'Broken ignores duplicate/item lifecycle order'
UNION ALL SELECT 'discovery_debug_trace_contract','user:1','popular_only','Broken ignores follows, filters, saved searches, components, safety, and collection visibility')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
