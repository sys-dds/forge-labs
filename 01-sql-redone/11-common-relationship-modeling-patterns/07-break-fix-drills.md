# Break Fix Drills

1. Remove the Class 8A enrollment join from `class_8a_roster`; Cy should appear.
2. Replace teaching assignments with `classes.primary_teacher_id`; Omar Science should disappear.
3. Remove the subject join from teaching assignments; Sarah English from Class 8B can leak.
4. Check submissions by assignment only; Ben should incorrectly appear submitted.
5. Join attendance through class instead of lesson 9001; Cy's Class 8B attendance should appear.
6. Add Cy to Class 8A enrollment and predict which proof changes before editing expected rows.

