# Design

## What this clinic teaches

Relationship tables preserve product facts that a flattened schema loses: class membership, subject-specific teaching, student submissions, and lesson attendance.

## Named rows and why each exists

- Row: Ada enrollment in Class 8A.
  Why it exists: proves a valid Class 8A student survives.
  Query/proof that uses it: `class_8a_roster`, assignment status, lesson attendance.
  Wrong behavior if removed: Ada disappears from roster, submission status, and attendance proof.
- Row: Ben enrollment in Class 8A.
  Why it exists: proves missing assignment is per student.
  Query/proof that uses it: `math_assignment_501_status`.
  Wrong behavior if removed: Ben's missing row cannot be proven.
- Row: Cy enrollment in Class 8B.
  Why it exists: proves Class 8B students do not leak into Class 8A.
  Query/proof that uses it: roster, assignment, and attendance exclusion checks.
  Wrong behavior if removed: class-scope bugs become invisible.
- Row: Sarah teaches Math to Class 8A.
  Why it exists: proves subject-specific teaching for Math.
  Query/proof that uses it: `class_8a_teaching_assignments`.
  Wrong behavior if removed: Math has no Class 8A teacher.
- Row: Omar teaches Science to Class 8A.
  Why it exists: proves Class 8A can have multiple teachers by subject.
  Query/proof that uses it: `class_8a_teaching_assignments`.
  Wrong behavior if removed: a single-teacher class model might look correct.
- Row: Sarah teaches English to Class 8B.
  Why it exists: proves Sarah's other assignment must not leak into Class 8A Math.
  Query/proof that uses it: teaching assignment exclusion check.
  Wrong behavior if removed: subject/class leakage is not tested.
- Row: Ada submission for assignment 501.
  Why it exists: proves submissions are student-specific facts.
  Query/proof that uses it: assignment status.
  Wrong behavior if removed: submitted status has no valid row.
- Row: Cy attendance in a Class 8B lesson.
  Why it exists: proves attendance is scoped by lesson and student.
  Query/proof that uses it: lesson 9001 attendance exclusion.
  Wrong behavior if removed: attendance leakage is not detected.

## Broken query bug

The broken views flatten teacher ownership onto classes, join students through subjects without class scope, treat assignment submission as class-level, and read attendance by class instead of lesson/student.

## Exact wrong result from the broken query

Class 8A roster includes Cy, Class 8A teaching assignments miss Omar Science or leak Sarah English, assignment 501 marks Ben submitted, and lesson 9001 attendance can include Cy.

## Correct result from the solution

Class 8A roster is Ada and Ben; teaching assignments are Sarah Math and Omar Science; assignment 501 status is Ada submitted and Ben missing; lesson 9001 attendance is Ada present and Ben absent.

## Proof assertions

The proof checks exact roster, Cy exclusions, Sarah/Omar subject assignments, no Sarah English leak, Ada submitted, Ben missing, exact lesson attendance, and no Cy Class 8B attendance leak.

## What the learner should notice

Class membership, teaching assignment, assignment submission, and attendance are different relationship/fact tables with different grains.

## Interview explanation target

Explain relationship tables, join tables with extra columns, fact tables, class enrolment versus teaching assignment, and why many-to-many should not be flattened too early.

