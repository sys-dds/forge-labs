# Safety Integrity For Beginners

## policy label
Plain-English meaning: a named policy finding such as spam_scam or borderline_label.
Tiny example from clinics 51-60: post_201 has spam_scam and is removed.
Common beginner mistake: treating the label as the final ranking score.
How to debug it: print label, treatment, and stage together.
What a senior engineer asks next: which policy version produced the label?

## hard filter
Plain-English meaning: removal before ranking can show the item.
Tiny example from clinics 51-60: clinic 52 keeps malware post_301 out of final_feed.
Common beginner mistake: ranking first and filtering later.
How to debug it: assert the item never reaches final_feed.
What a senior engineer asks next: is the filter replayable offline?

## downranking
Plain-English meaning: reducing distribution without removing the item.
Tiny example from clinics 51-60: clinic 51 reduces post_401 for borderline clickbait.
Common beginner mistake: removing every borderline item.
How to debug it: check downranked_items and final order.
What a senior engineer asks next: what penalty is applied and capped?

## contextual label
Plain-English meaning: an information label attached to content that can remain visible.
Tiny example from clinics 51-60: post_501 receives a context label.
Common beginner mistake: confusing inform with review.
How to debug it: inspect informed_items separately from review_queue.
What a senior engineer asks next: does the label copy match policy version?

## review queue
Plain-English meaning: items needing human or deeper review.
Tiny example from clinics 51-60: clinic 56 sends post_101, post_301, post_401 to review.
Common beginner mistake: routing by raw report count.
How to debug it: compare reporter reliability weights.
What a senior engineer asks next: what SLA and priority apply?

## appeal
Plain-English meaning: creator/user challenge to a decision.
Tiny example from clinics 51-60: case_501 is restored after creator evidence.
Common beginner mistake: overwriting the original decision.
How to debug it: inspect audit_log original and final decisions.
What a senior engineer asks next: can reversals update ranking caches?

## reversal
Plain-English meaning: a prior decision is changed after new evidence.
Tiny example from clinics 51-60: case_201 reverses because the report was stale.
Common beginner mistake: never reversing automated decisions.
How to debug it: assert reversal_rows and reasons.
What a senior engineer asks next: how are downstream impressions repaired?

## audit trail
Plain-English meaning: stored evidence that explains the decision later.
Tiny example from clinics 51-60: clinic 58 audit rows include original_decision and final_decision.
Common beginner mistake: logging only the final state.
How to debug it: require evidence_snapshot in proof.
What a senior engineer asks next: who can query this trail and for how long?
