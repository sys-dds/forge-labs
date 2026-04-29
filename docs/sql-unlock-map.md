# SQL Unlock Map

- Relationships unlock graph queries because follows, blocks, mutes, comments, and matches are all modeled as connected rows.
- Graph queries unlock feed candidates because feeds begin by asking which authors and posts are visible to the viewer.
- Feed candidates unlock ranking because a ranking system cannot score rows until SQL prepares eligible inputs.
- Swipes unlock matching because mutual LIKEs and candidate exclusions start as database relationships.
- Pagination unlocks production feeds because stable cursors prevent duplicate or missing rows while new data arrives.
- Recursive CTEs unlock comments/categories because parent-child tables need tree traversal.
- Constraints unlock safe concurrent backend behavior later because the database is the final guard when requests race.
