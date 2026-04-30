# Read/Write Path

## Write path

- Create trend window 3001.
- Insert interaction events for topics 101, 102, and 103.
- Insert velocity, unique_actor, and freshness components.
- Write abuse evidence 6001 and policy treatment 7001 for spam topic 102.

## Read path

- Read components by topic/window.
- Sum component_value for component totals.
- Suppress topics with hide treatment.
- Use freshness component to show old trend decay.

The verification query is the product read contract over those source rows.
