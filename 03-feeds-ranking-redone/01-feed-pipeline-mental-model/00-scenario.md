# Scenario

Ada opens a home feed and the backend must move from inventory to eligibility, candidates, features, scoring, mixing, final page, and feedback logging.

The important behavior is deterministic: expected final feed [101,501,401,701]; broken ranker returned muted Cy 201, blocked Noor 301, or unsafe Omar 601 because it scored before eligibility.
