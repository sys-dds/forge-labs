# Interview Explanation

## Direct answer

I would model enrolment, teaching assignments, submissions, and attendance as separate relationship or fact tables because each one has a different grain.

## Dataset walkthrough

Ada and Ben are Class 8A students; Cy is Class 8B. Sarah teaches Math to Class 8A and English to Class 8B. Omar teaches Science to Class 8A. Assignment 501 belongs to Class 8A Math; Ada submitted it and Ben did not. Lesson 9001 has Ada present and Ben absent, while Cy's attendance belongs to a Class 8B lesson.

## Query reasoning

Roster starts from Class 8A enrollment. Teaching assignments start from Class 8A plus subject/teacher rows. Assignment status starts from assignment 501's class enrollment and left joins each student's submission. Attendance starts from lesson 9001 and joins attendance by lesson/student.

## Common mistake

The common mistake is flattening many-to-many relationships into one `teacher_id` or one class-level submission flag. That loses Omar Science and marks Ben submitted because Ada submitted.

## Senior trade-off

More relationship tables create more joins, but each table preserves a product fact that future queries can trust.

## Follow-up answer

If grading were added, I would add grade columns to submissions or a submission_grades table, not store a class-level grade on assignment 501.

