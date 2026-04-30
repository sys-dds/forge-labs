# Clinic Format

Each clinic has a broken query or implementation because debugging is part of the lesson. A proof that fails against the broken version is not noise; it is the moment where the product rule becomes executable.

Named rows matter because vague examples hide bugs. "Ben post 102 has zero comments" is stronger than "a post has no comments" because you can inspect that row, predict the result, and catch an accidental inner join.

Future clinics should stay small:

- Use one product scenario.
- Give every seed row a reason to exist.
- Keep one broken surface and one corrected surface.
- Make the proof fail for a specific row-level reason.
- Explain the failure with table names, query names, and row identifiers.
- Avoid adding a folder just because a course outline would look bigger.

