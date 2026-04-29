# Challenge Manifest Schema

The manifest is a simple `key=value` file. Scripts treat it as plain text and require stable keys.

## Required Keys

```text
id=stable-pack-id
title=Human readable title
source_chapter=01-sql/04-followers-and-social-graph
difficulty=foundation-plus
concepts=comma-separated learning targets
dataset_entities=comma-separated named rows
positive_cases=short list of rows that must appear
negative_cases=short list of exclusions
edge_cases=short list of boundary behaviors
proof_file=05-proof.tests.sql
solution_file=04-solution.sql
estimated_time=25 minutes
what_to_break=comma-separated intentional mistakes
```

## Rules

- Keep values one line each.
- Use repo-relative paths for `source_chapter`, `proof_file`, and `solution_file`.
- Keep `id` lowercase with hyphens so scripts can display it cleanly.
- `positive_cases`, `negative_cases`, and `edge_cases` should mention the named rows used by the proof tests.
