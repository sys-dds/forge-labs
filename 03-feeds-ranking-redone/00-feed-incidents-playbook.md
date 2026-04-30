# Feed Incidents Playbook

## Reproduce

Plain-English meaning: rebuild the exact bad feed before changing code.

Tiny example from clinic 29: the incident starts with [701, 101, 102, 103, 801].

Common beginner mistake: guessing the cause from one screenshot.

How to debug it: freeze the inventory and verify the bad output in a proof.

What a senior engineer asks next: can on-call replay this from logs?

## Diagnose

Plain-English meaning: connect each symptom to a root cause.

Tiny example from clinic 29: blocked 701 points to eligibility_filter_missing, repeated Ben items point to diversity_cap_disabled.

Common beginner mistake: writing one broad root cause such as ranking bug.

How to debug it: make the root cause list exact enough to map to mitigations.

What a senior engineer asks next: which root cause explains the largest blast radius?

## Mitigate and regress

Plain-English meaning: restore the disabled protections and keep checks for the future.

Tiny example from clinic 29: restore hard block filter, author cap, freshness window, notification dedupe, and exploration slot.

Common beginner mistake: patching the feed list without proving deduped notifications or exploration recovery.

How to debug it: run regression checks after mitigation, not before.

What a senior engineer asks next: which check belongs in release gates?
