# Workshop Format

Each chapter is implementation-first and contains:

- `README.md` for reading order and run command
- `00-concept.explainer.md` for the mental model
- numbered `.solution.sql` files with working SQL
- `90-common-mistakes.sql` with wrong patterns
- `91-common-mistakes.explainer.md` explaining why those mistakes hurt
- `98-extension-tasks.md` for small edits
- `99-chapter-proof.tests.sql` with executable assertions

The harness runs numbered solution files first, then the proof file. It ignores `_template`.
