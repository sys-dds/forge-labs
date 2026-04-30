SET search_path TO bip_pim_037;
WITH raw_matches AS (SELECT 'post' entity_type,post_id entity_id,title FROM posts WHERE title ILIKE '%workshop%' UNION ALL SELECT 'listing',listing_id,title FROM listings WHERE title ILIKE '%workshop%'), checks AS (
SELECT 'query_recorded' contract_name,'query:1001' subject_id,'workshop' observed_value,'Broken only knows raw text' expected_reason
UNION ALL SELECT 'filter_applied','query:1001','none','Broken ignores filters'
UNION ALL SELECT 'facet_count','facet:3001',(SELECT count(*)::text FROM raw_matches),'Broken counts facets from raw matches'
UNION ALL SELECT 'saved_search_contract','saved:4001','workshop','Broken ignores saved filter state'
UNION ALL SELECT 'paused_saved_search_no_alert','saved:4002','false','Broken alerts paused saved search'
UNION ALL SELECT 'unsafe_result_suppressed','listing:6001',(EXISTS(SELECT 1 FROM raw_matches WHERE entity_type='listing' AND entity_id=6001))::text,'Broken includes unsafe listing'
UNION ALL SELECT 'search_debug_trace','query:1001','raw='||(SELECT string_agg(entity_type||':'||entity_id,'|' ORDER BY entity_type,entity_id) FROM raw_matches),'Broken trace ignores filters, facets, saved state, blocks, and treatments')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
