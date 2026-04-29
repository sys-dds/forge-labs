# SQL Unlock Map

- Relationships unlock graph queries: users become nodes, follows become directed edges, and blocks/mutes become safety edges.
- Follows unlock followers, following, and mutual follows: the same table answers all three questions depending on edge direction.
- Mutual follows unlock suggestions: second-degree traversal finds users followed by people I follow.
- Suggestions plus posts unlock feed candidates: SQL gathers eligible rows before any ranking algorithm scores them.
- Feed candidates plus metrics unlock ranking inputs: counts and relationship flags become raw columns for later scoring work.
- Cursor pagination unlocks stable feed scrolling: `(created_at, id)` keeps pages deterministic when timestamps tie or new rows arrive.
- Recursive CTEs unlock comments and categories: parent-child rows can be expanded into depth/path ordered trees.
- Swipes unlock mutual matches: two LIKE edges in opposite directions become a match.
- Candidate exclusions unlock matching recommendations: self, already-swiped, blocked, and inactive users are removed before ranking or recommendation logic begins.
- Constraints unlock safe concurrent backend behavior later: composite keys and CHECK rules remain correct when two requests race.
