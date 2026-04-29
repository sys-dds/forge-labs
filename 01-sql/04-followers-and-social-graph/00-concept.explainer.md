# Followers and Social Graph

## Plain-English Concept

A follow is a directed edge: follower_id points from the actor, followee_id points to the target.

## Real-World Backend Pattern

The same directed follow edge answers followers, following, mutual follows, and second-degree suggestions.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. Followers of Ada are rows where Ada is followee_id.
2. Following for Ada are rows where Ada is follower_id.
3. Mutual follows require two opposite edges.
4. Suggestions walk from Ada to people she follows, then to people they follow.
5. Blocks remove unsafe users; mutes suppress feed candidates without deleting follows.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- confusing follower and followee direction
- missing self-follow guard
- suggestions include already-followed users
- treating block and mute as identical
- missing block filter in suggestions

## Next Unlock

Graph traversal provides the viewer-specific author set used by feed candidate generation.
