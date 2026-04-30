# Design

## What this clinic teaches

Stories Ephemeral Content Snapchat Patterns teaches story tray ranking versus public vertical feed ranking with expiry and eligibility rules.

## Named users/content and why each exists

- Item: Ada viewer
- Why it exists: Ada is UK English adult and sets language/location eligibility.
- Simulation/proof that uses it: spotlight_exact.
- Wrong behavior if removed: eligibility would have no viewer context.

- Item: Ben story 101
- Why it exists: Ben close-friend unexpired story is the only tray item.
- Simulation/proof that uses it: story_tray_exact.
- Wrong behavior if removed: valid friend story would not be proven.

- Item: Ben story 102
- Why it exists: Ben expired story proves expiry filtering.
- Simulation/proof that uses it: excluded_items.
- Wrong behavior if removed: expired stories could show in tray.

- Item: Cy story 201
- Why it exists: Cy muted story proves friend status is not enough.
- Simulation/proof that uses it: excluded_items.
- Wrong behavior if removed: muted friend stories could show.

- Item: Noor story 301
- Why it exists: Noor blocked story proves block exclusion.
- Simulation/proof that uses it: excluded_items.
- Wrong behavior if removed: blocked stories could show.

- Item: Maya Spotlight 701
- Why it exists: Maya high-completion video ranks first.
- Simulation/proof that uses it: spotlight_exact.
- Wrong behavior if removed: completion scoring would be ignored.

- Item: Omar Spotlight 601
- Why it exists: Omar wrong-language video proves language eligibility.
- Simulation/proof that uses it: excluded_items.
- Wrong behavior if removed: wrong-language Spotlight would show.

- Item: Theo Spotlight 801
- Why it exists: Theo reported video proves negative feedback exclusion.
- Simulation/proof that uses it: excluded_items.
- Wrong behavior if removed: reported content could rank by likes.

## Broken ranking behavior

broken output includes expired Ben 102, muted Cy 201, blocked Noor 301, wrong-language Omar 601, and reported Theo 801 while ranking Spotlight by likes only.

## Exact wrong result from the broken version

broken output includes expired Ben 102, muted Cy 201, blocked Noor 301, wrong-language Omar 601, and reported Theo 801 while ranking Spotlight by likes only.

## Correct result from the solution

The corrected simulation returns stories [101], spotlight [701,501].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected story tray [101] and Spotlight [701,501]; broken simulation included expired 102, muted 201, blocked 301, wrong-language 601, reported 801, or ranked likes before completion.

## What the learner should notice

Ben story 101 survives for a specific reason, Cy story 201 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain stories and ephemeral content using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
