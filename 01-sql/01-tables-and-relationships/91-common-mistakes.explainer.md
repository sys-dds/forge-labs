# Tables and Relationships Common Mistakes

1. **Missing one-to-one protection**: Duplicate profile or settings rows make the backend guess which row is real.
2. **Missing foreign keys**: Orphan posts or profiles survive after the parent user is gone or was never valid.
3. **Duplicate many-to-many edges**: Counts and recommendations become inflated when the same relationship can be inserted twice.
