# Model Answer

Post `101` has two likes and three comments. A direct join creates six joined rows because every like pairs with every comment. I would aggregate likes by post and comments by post first, then join those two count tables back to candidate posts.
