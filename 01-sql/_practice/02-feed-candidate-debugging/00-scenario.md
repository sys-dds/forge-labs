# Scenario

Ada opens her feed.

Ada follows Ben, Cy, and Noor. Ada muted Cy and blocked Noor. Diya is a visible author in the database, but Ada does not follow Diya. Ben has two posts. One has likes and comments. The other has a like but no comments, which proves the query must not use an inner join for comments.

The backend question:

```text
Which followed, unmuted, unblocked author posts are eligible feed candidates, and what are their exact engagement counts?
```
