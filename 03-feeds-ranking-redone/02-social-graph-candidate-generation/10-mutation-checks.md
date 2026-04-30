# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Include Theo 601 as a public post | proof fails exact candidate IDs and no_social_path rejection |
| Drop Diya 401 shared group collection | proof fails final candidate list [101,401,501] |
| Duplicate Lina 501 through two traversals | proof fails no duplicate candidate IDs |
| Change Ben 101 source to followed_author | proof fails source assertion for 101 close_friend |
| Remove Maya traversal explanation for Lina 501 | proof fails debug_trace assertion mentioning Maya |
