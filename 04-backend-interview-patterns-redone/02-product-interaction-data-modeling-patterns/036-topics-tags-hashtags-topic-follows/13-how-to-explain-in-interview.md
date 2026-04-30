# How To Explain In Interview

## Direct answer

Use normalized topics and hashtags, link content and creators to topics, store user topic follows, and apply block plus treatment rows when building the discovery surface.

## Actual tables

- `users`
- `topics`
- `hashtags`
- `posts`
- `creators`
- `content_topic_links`
- `creator_topic_links`
- `user_topic_follows`
- `block_edges`
- `content_treatments`

## Actual trap rows

- Ada user 1 follows topic 101 through follow 5001.
- Hashtag 301 #buildinpublic normalizes to topic 101.
- Post 1002 is deleted and must be hidden.
- Creator 202 is blocked by Ada through block 6001.
- Post 1003 is downranked by treatment 7001 and needs trace.

## Exact query mechanics

The query builds followed_topics, visible_topic_posts, visible_topic_creators, and treatment_trace CTEs, then emits normalized_hashtag_topic, followed_topic_content, blocked_creator_hidden, and topic_debug_trace.

## Write path

Insert topic 101 and hashtag 301 normalized to it. Link posts and creators to topic 101. Write Ada follow 5001, block 6001, and content treatment 7001.

## Discovery/product follow-up

The product can explain why a topic item appeared: followed topic, linked content, creator topic, and any treatment.

## Scaling follow-up

At larger size, materialize topic surfaces from these source rows, but keep the source contract inspectable.
