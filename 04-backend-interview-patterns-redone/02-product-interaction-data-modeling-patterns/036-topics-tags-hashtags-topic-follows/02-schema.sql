SET search_path TO bip_pim_036;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE topics(topic_id int PRIMARY KEY, topic_name text NOT NULL, topic_type text NOT NULL CHECK(topic_type IN ('system','user_created','hashtag')), visibility text NOT NULL CHECK(visibility IN ('public','private','followers_only')));
CREATE TABLE hashtags(hashtag_id int PRIMARY KEY, raw_text text NOT NULL, normalized_text text NOT NULL, topic_id int NOT NULL REFERENCES topics(topic_id));
CREATE TABLE creators(creator_id int PRIMARY KEY, user_id int NOT NULL REFERENCES users(user_id), creator_name text NOT NULL, creator_state text NOT NULL CHECK(creator_state IN ('active','deleted','hidden')));
CREATE TABLE posts(post_id int PRIMARY KEY, creator_id int NOT NULL REFERENCES creators(creator_id), body text NOT NULL, content_state text NOT NULL CHECK(content_state IN ('active','deleted','hidden','downranked')));
CREATE TABLE content_topic_links(link_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), post_id int NOT NULL REFERENCES posts(post_id), link_source text NOT NULL);
CREATE TABLE creator_topic_links(link_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), creator_id int NOT NULL REFERENCES creators(creator_id), link_source text NOT NULL);
CREATE TABLE user_topic_follows(follow_id int PRIMARY KEY, user_id int NOT NULL REFERENCES users(user_id), topic_id int NOT NULL REFERENCES topics(topic_id), follow_state text NOT NULL CHECK(follow_state IN ('active','paused')));
CREATE TABLE block_edges(block_id int PRIMARY KEY, blocker_user_id int NOT NULL REFERENCES users(user_id), blocked_user_id int NOT NULL REFERENCES users(user_id));
CREATE TABLE content_treatments(treatment_id int PRIMARY KEY, post_id int NOT NULL REFERENCES posts(post_id), treatment text NOT NULL CHECK(treatment IN ('allow','downrank','hide','review')), reason text NOT NULL);

