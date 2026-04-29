# Tables and Relationships

## Plain-English Concept

Tables hold facts. Foreign keys describe which facts depend on other facts. Cardinality tells the backend whether one row, many rows, or an optional row should exist.

## Real-World Backend Pattern

A social product needs users, profiles, posts, settings, and early follow relationships.

## Mental Model

Rows are backend facts. Tables store facts, constraints protect facts, relationships connect facts, and queries shape facts into the result or candidate set the application needs.

## When To Use It

Use these patterns when modeling ownership, profile details, authored content, settings, and relationships between users.

## When Not To Use It

Do not hide relationship rules only in application code when the database can enforce the shape.

## Interview Explanation

I model backend concepts by choosing the table that owns the fact, then encode one-to-one, one-to-many, or many-to-many relationships with keys and constraints.

## Next Unlock

relationship modeling unlocks graph queries and every later backend feature in this path
