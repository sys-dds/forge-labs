# Debugging Notes

Cy is enrolled in Class 8B, so Cy appearing in `class_8a_roster` proves the query is reading all students instead of Class 8A enrollment rows.

Sarah teaches Math to Class 8A and English to Class 8B. If Sarah English appears in `class_8a_teaching_assignments`, the query joined by teacher but forgot the class and subject assignment grain.

Omar teaches Science to Class 8A. A single `teacher_id` on `classes` cannot represent Omar's Science assignment without overwriting Sarah's Math assignment.

Ada submitted assignment 501, but Ben did not. A class-level submission check marks Ben submitted even though no `(501, Ben)` submission row exists.

Cy's Class 8B attendance on lesson 9101 proves attendance belongs to a lesson/student pair. Joining attendance by class name instead of lesson 9001 leaks Cy into the Class 8A lesson.

Maya is an admin and does not appear in roster, assignment status, or attendance because role and relationship rows are separate facts.

