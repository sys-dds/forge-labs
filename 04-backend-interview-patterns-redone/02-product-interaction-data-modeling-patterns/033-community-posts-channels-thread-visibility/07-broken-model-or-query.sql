SET search_path TO bip_pim_033;
WITH raw_posts AS (SELECT m.user_id viewer_user_id,p.* FROM community_memberships m JOIN community_posts p USING(community_id)), checks AS (
SELECT 'public_channel_post_visible' contract_name,'user:1/post:1001' subject_id,(EXISTS(SELECT 1 FROM raw_posts WHERE viewer_user_id=1 AND post_id=1001))::text observed_value,'Broken returns community posts by community_id only' expected_reason
UNION ALL SELECT 'private_channel_member_visible','user:2/post:1002',(EXISTS(SELECT 1 FROM raw_posts WHERE viewer_user_id=2 AND post_id=1002))::text,'Broken happens to show private post to Ben'
UNION ALL SELECT 'private_channel_non_member_hidden','user:3/post:1002',(EXISTS(SELECT 1 FROM raw_posts WHERE viewer_user_id=3 AND post_id=1002))::text,'Broken leaks private channel post to Cy'
UNION ALL SELECT 'removed_member_hidden','user:4',(EXISTS(SELECT 1 FROM raw_posts WHERE viewer_user_id=4))::text,'Broken shows posts to removed member Diya'
UNION ALL SELECT 'deleted_post_hidden','post:1004',(EXISTS(SELECT 1 FROM raw_posts WHERE post_id=1004))::text,'Broken shows deleted post 1004'
UNION ALL SELECT 'pinned_post_contract','community:101',string_agg(post_id::text,'|' ORDER BY created_rank),'Broken pinned set ignores visibility filters' FROM raw_posts WHERE viewer_user_id=1 AND is_pinned
UNION ALL SELECT 'thread_reply_contract','thread:6001',(SELECT parent_post_id||'->'||reply_post_id FROM community_threads WHERE thread_id=6001),'Broken still keeps thread but visibility is wrong'
UNION ALL SELECT 'channel_visibility_trace','community:101',string_agg(viewer_user_id||':'||post_id,'|' ORDER BY viewer_user_id,post_id),'Broken trace leaks private/deleted/removed rows' FROM raw_posts)
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
