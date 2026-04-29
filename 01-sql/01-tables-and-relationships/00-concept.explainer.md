# Tables and Relationships

## Plain-English Concept

Tables model backend facts; keys and foreign keys describe which facts are allowed to depend on other facts.

## Real-World Backend Pattern

A social product has account rows, public profile rows, authored posts, optional settings, and the first preview of follow edges.

## Mental Model

Think in three layers: the fact stored in a row, the rule that keeps the fact safe, and the query that turns safe facts into a backend response or candidate set.

## Step-By-Step Example

1. A user row is the node every other feature points at.
2. A profile row is one-to-one because one account owns one public profile.
3. Posts are one-to-many because one author can publish many rows.
4. Settings are optional because a user can exist before choosing preferences.
5. The follow preview shows that relationships between users are rows too.

## Common Interview Phrasing

"I would model the durable facts first, put invariants in the database where races cannot bypass them, then shape the query so the application receives only the rows and columns it is allowed to use."

## What Can Go Wrong

- profile table with separate id but no unique user_id
- posts without author foreign key
- follows without composite primary key
- settings as ever-growing nullable columns on users

## Next Unlock

Once users can be related to profiles, posts, settings, and other users, the next chapter can protect those relationships with constraints.
