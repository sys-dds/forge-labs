# Abuse And Trust Debugging Playbook

## evidence row
Plain-English meaning: the row that proves why a decision happened.
Tiny example from clinics 51-60: post_201 has clickbait_fastback_ratio in clinic 53.
Common beginner mistake: relying on a final score with no evidence.
How to debug it: print content_id, evidence, treatment.
What a senior engineer asks next: is evidence stale or policy-versioned?

## reporter reliability
Plain-English meaning: how much to trust a reporter based on prior precision.
Tiny example from clinics 51-60: Ada 0.9 and Ben 0.8 outweigh troll mass reports.
Common beginner mistake: counting raw reports only.
How to debug it: compute weighted report total.
What a senior engineer asks next: how do reliability scores update after review?

## trust score
Plain-English meaning: account/source quality signal separate from popularity.
Tiny example from clinics 51-60: Omar is viral but low source quality in clinic 55.
Common beginner mistake: follower count equals trust.
How to debug it: inspect trust_score_rows.
What a senior engineer asks next: which components are gameable?

## risk score
Plain-English meaning: numeric risk estimate from policy/evidence.
Tiny example from clinics 51-60: post_401 fake engagement gets risk 65 in clinic 60.
Common beginner mistake: using risk as the only product decision.
How to debug it: map risk to remove/reduce/inform/review/allow.
What a senior engineer asks next: are thresholds calibrated by harm severity?

## spam pattern
Plain-English meaning: repeated behavior that indicates spam.
Tiny example from clinics 51-60: spam_scam removes post_701 in clinic 53.
Common beginner mistake: downranking scams instead of removing them.
How to debug it: assert rejected_items stage safety_policy.
What a senior engineer asks next: does spam evidence generalize across domains?

## clickbait
Plain-English meaning: content that gets clicks but quick exits.
Tiny example from clinics 51-60: post_201 has fastback ratio 80/200 = 0.4.
Common beginner mistake: rewarding clicks without dwell.
How to debug it: compute fastback ratio.
What a senior engineer asks next: what ratio is too high per surface?

## engagement farming
Plain-English meaning: prompts that inflate reactions without value.
Tiny example from clinics 51-60: post_301 says comment YES.
Common beginner mistake: ranking comments as quality.
How to debug it: inspect text pattern and dwell.
What a senior engineer asks next: does suppression hurt legitimate calls to action?

## fake engagement
Plain-English meaning: likes/reposts that do not represent real user interest.
Tiny example from clinics 51-60: bot_a/b/c/d boost post_201 in two minutes.
Common beginner mistake: trusting all engagement equally.
How to debug it: compare account age and burst window.
What a senior engineer asks next: which clusters are coordinated?

## bot ring
Plain-English meaning: connected fake accounts acting together.
Tiny example from clinics 51-60: bot_a through bot_d form burst evidence.
Common beginner mistake: looking at accounts one by one only.
How to debug it: group by time window and shared target.
What a senior engineer asks next: can the ring switch targets?

## coordinated abuse
Plain-English meaning: multiple accounts cooperate to manipulate feeds or reports.
Tiny example from clinics 51-60: Noor coordinates reposts in clinic 54.
Common beginner mistake: missing the coordinator row.
How to debug it: assert suspicious coordinator evidence.
What a senior engineer asks next: how does graph evidence join safety evidence?
