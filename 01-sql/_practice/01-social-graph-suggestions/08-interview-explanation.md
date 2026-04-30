# Interview Explanation

For follow suggestions, I treat `follows` as a directed edge from follower to followee.

The traversal is:

```text
Ada
-> users Ada follows
-> users those people follow
-> remove Ada, already-followed users, and blocked users
-> deduplicate the safe suggestion set
```

The important backend detail is that reachability is not enough. Noor is reachable, but Ada blocked Noor, so the safety predicate wins over graph distance. Diya remains because she is second-degree, not already followed, not Ada, and not blocked.
