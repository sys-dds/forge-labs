# How To Explain In Interview

## Direct answer

Model safety as source interactions plus evidence-backed signals and treatment rows.

## Actual tables

Use `users, posts, post_reactions, comments, follow_edges, report_events, abuse_signal_events, abuse_signal_evidence, policy_treatments` in schema `bip_pim_019`.

## Actual trap rows

Cy user 3 repeats duplicate comments 301/302/303 creating spam signal 7001, Ben user 2 has like burst signal 7002 on post 201, Diya user 4 has normal engagement and no signal, report 6001 plus evidence rows 8001 and 8002 put Cy into review, and treatment 9001 reviews Cy while treatment 9002 allows Diya.

## Exact query mechanics

Join abuse_signal_events to abuse_signal_evidence and policy_treatments, distinguish duplicate comment and fake like burst evidence from normal engagement, and emit safety debug traces.

## Write path

Append source rows first, derive signal/evidence rows, then write treatment rows with reasons.

## Moderation/safety follow-up

Ask which evidence rows explain a downrank, review, removal, or restoration.

## Scaling follow-up

Keep the trace query stable if signal generation is later automated.
