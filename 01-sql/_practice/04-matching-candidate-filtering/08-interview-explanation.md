# Interview Explanation

The first matching algorithm is exclusion.

Before scoring fit, the backend removes candidates who cannot or should not be shown: the viewer, inactive profiles, blocked profiles, and profiles the viewer already swiped. Mutual matches are a separate query that requires both people to have `LIKE` actions.

Preference fit comes after that raw candidate set. Maya is safe and fits Ada's age, city, and shared-interest target. Omar is safe enough to inspect as a raw candidate, but his age keeps him out of the preference-fit result.
