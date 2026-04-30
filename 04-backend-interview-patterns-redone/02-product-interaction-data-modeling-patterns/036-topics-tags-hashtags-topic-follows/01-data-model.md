# Data Model

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

## Constraints

- Hashtags normalize to topic rows before discovery reads.
- Topic surfaces require an active user_topic_follows row for the viewer.
- Deleted posts and blocked creators are suppressed.
- Downranked content may appear only with a treatment trace.

## Trap rows

- Ada user 1 follows topic 101 through follow 5001.
- Hashtag 301 #buildinpublic normalizes to topic 101.
- Post 1002 is deleted and must be hidden.
- Creator 202 is blocked by Ada through block 6001.
- Post 1003 is downranked by treatment 7001 and needs trace.

## Why this shape

Topic discovery needs normalized relationships and visibility/treatment rows. Raw hashtag text cannot explain creator matches, follows, blocks, or downrank decisions.
