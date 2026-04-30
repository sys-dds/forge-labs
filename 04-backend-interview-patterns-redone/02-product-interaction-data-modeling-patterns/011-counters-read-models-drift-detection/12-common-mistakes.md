# Common Mistakes

- Ignoring the named trap rows: post 101 has two active likes but stored like_count 3, post 101 has one live comment and stored comment_count 1, Ben user 2 has two active followers but stored follower_count 1, Ada user 1 has two unread notifications and stored unread_count 2.
- Trusting a display-oriented row when source tables disagree.
- Dropping lifecycle, visibility, or viewer-specific controls from the read contract.
