# Design

## What this clinic teaches

Replay a fixed feed inventory and compare the derived actual feed with a golden feed before shipping.

## Product surface and operating problem

Ada's feed is being checked as an operating system, not as a pretty list. The clinic follows one fixed inventory through replay, explanation, measurement, or incident handling.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: Ben in-network post anchors followed-author replay
- Simulation/proof that uses it: final feed assertion keeps 101
- Wrong behavior if removed: following replay loses its control row

- Item: 501
- Why it exists: Lina similar-topic post checks topic retrieval
- Simulation/proof that uses it: final feed assertion keeps 501
- Wrong behavior if removed: topic match regression is invisible

- Item: 601
- Why it exists: Maya group post checks group candidate source
- Simulation/proof that uses it: final feed assertion keeps 601
- Wrong behavior if removed: group source can disappear

- Item: 701
- Why it exists: Noor blocked post checks hard block rejection
- Simulation/proof that uses it: assert_rejected catches blocked_author
- Wrong behavior if removed: blocked content can leak

- Item: 801
- Why it exists: Omar unsafe post checks integrity rejection
- Simulation/proof that uses it: assert_rejected catches unsafe_content
- Wrong behavior if removed: unsafe content can leak

- Item: 901
- Why it exists: Theo exploration post checks reserved exploration
- Simulation/proof that uses it: final feed and trace keep 901
- Wrong behavior if removed: exploration disappears silently

## Broken operating/ranking behavior

Broken feed leaks 701 and omits 901.

## Exact wrong result from the broken version

Broken feed leaks 701 and omits 901.

## Correct result from the solution

Actual feed [101, 501, 601, 901], rejected 701 blocked_author and 801 unsafe_content, regression_report [].

## Proof assertions

Exact final feed, rejected reasons, empty regression report, replay status, and debug traces for 701, 801, 901.

## Beginner mental model

Follow one item from inventory to rejection or final placement. The item ID is the breadcrumb.

## Senior engineering review angle

Ask whether the proof protects the operating invariant, the debug trace, and the user-visible failure.

## What the learner should notice

A feed answer is only trustworthy when the explanation path and the metric or incident check agree with the final IDs.

## Interview explanation target

Explain the failure, the corrected rule, and the smallest proof that would catch a regression.
