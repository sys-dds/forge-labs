# Clinic Format

Each clinic includes a broken simulation because feed bugs are easier to understand when the wrong ordered output is visible. Deterministic expected output matters because ranking changes can otherwise hide behind plausible scores. Every final item needs a reason label so the learner can answer why Ada saw it. Debugging needs traces and rejection reasons because final pages alone do not explain missing or removed items.

Future clinics should start with named rows, exact wrong output, and proof messages before adding code. Do not add broad folders or vague prose when one dataset and one proof can teach the rule.

## Hardened clinic standard
Each clinic keeps its behavior in clinic-local functions. Evidence maps and mutation checks are required so every named item is tied to a proof, trace, and drill. Shared helpers stay small and cannot contain clinic business rules.

## Part Two Clinic Files

New clinics include beginner walkthroughs, shortcut audits, and mutation checks. Each new clinic owns its broken simulation, solution, and proof file.
