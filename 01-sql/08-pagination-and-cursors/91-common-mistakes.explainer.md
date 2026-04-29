# Pagination and Cursors Common Mistakes

1. **Unshaped results**: Returning every column leaks data and couples API responses to table layout.
2. **Missing visibility filters**: Feeds, profiles, and matching candidates must respect blocks, mutes, privacy, or prior actions.
3. **Row multiplication**: Joining multiple one-to-many tables can inflate counts unless aggregation is isolated.
