# INNER JOIN vs LEFT JOIN vs anti-join

Scenario: Users must complete identity checks before marketplace selling.

You will query `users, required_checks, user_checks`. The important trap rows are 102 missing address; 104 no checks; 103 failed identity; 105 inactive excluded. The solution must pass both the base and variant seeds, so do not hard-code answer IDs.
