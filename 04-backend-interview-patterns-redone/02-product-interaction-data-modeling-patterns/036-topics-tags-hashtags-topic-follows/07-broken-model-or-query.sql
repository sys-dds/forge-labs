SET search_path TO bip_pim_036;
WITH raw_hash AS (SELECT p.* FROM posts p WHERE p.body ILIKE '%Build%' OR p.body ILIKE '%#BuildInPublic%'), checks AS (
SELECT 'normalized_hashtag_topic' contract_name,'hashtag:301' subject_id,'raw_text_only' observed_value,'Broken ignores normalized topic_id' expected_reason
UNION ALL SELECT 'followed_topic_content','user:1',COALESCE(string_agg(post_id::text,'|' ORDER BY post_id),'none'),'Broken raw text search ignores topic follows and treatments' FROM raw_hash
UNION ALL SELECT 'followed_topic_creator','user:1','none','Broken raw text search cannot derive creator_topic_links'
UNION ALL SELECT 'deleted_content_hidden','post:1002',(EXISTS(SELECT 1 FROM raw_hash WHERE post_id=1002))::text,'Broken can include deleted text matches'
UNION ALL SELECT 'blocked_creator_hidden','creator:202','false','Broken ignores block_edges'
UNION ALL SELECT 'downranked_content_trace','post:1003','missing','Broken has no treatment trace'
UNION ALL SELECT 'topic_debug_trace','user:1','raw_hash_only','Broken trace omits follows, links, blocks, and treatments')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
