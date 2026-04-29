# Followers and Social Graph

## Plain-English Concept

Followers and Social Graph turns raw rows into dependable backend behavior that the application can trust.

## Real-World Backend Pattern

This chapter teaches self-referencing many-to-many queries, mutual follows, suggestions, blocks, and mutes through the Forge Labs backend domain.

## Mental Model

Rows are backend facts. Tables store facts, constraints protect facts, relationships connect facts, and queries shape facts into the result or candidate set the application needs.

## When To Use It

Use it when SQL can protect or shape backend data closer to where the facts live.

## When Not To Use It

Avoid it when the query hides product rules or when a later chapter has not introduced the safer pattern yet.

## Interview Explanation

I explain followers and social graph by naming the backend behavior first, then the SQL shape that protects or returns it.

## Next Unlock

graph queries unlock feed candidates and recommendations
