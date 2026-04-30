CREATE VIEW class_8a_roster AS
SELECT student.name AS student_name
FROM classes class_rows
JOIN class_enrollments enrollment_rows ON enrollment_rows.class_id = class_rows.id
JOIN people student ON student.id = enrollment_rows.student_id
WHERE class_rows.name = 'Class 8A'
ORDER BY student.name;

CREATE VIEW class_8a_teaching_assignments AS
SELECT teacher.name AS teacher_name, subject_rows.name AS subject_name
FROM classes class_rows
JOIN teaching_assignments assignment_rows ON assignment_rows.class_id = class_rows.id
JOIN subjects subject_rows ON subject_rows.id = assignment_rows.subject_id
JOIN people teacher ON teacher.id = assignment_rows.teacher_id
WHERE class_rows.name = 'Class 8A'
ORDER BY subject_rows.name;

CREATE VIEW math_assignment_501_status AS
SELECT
  student.name AS student_name,
  CASE WHEN submission_rows.assignment_id IS NULL THEN 'missing' ELSE 'submitted' END AS submission_status
FROM assignments assignment_rows
JOIN class_enrollments enrollment_rows ON enrollment_rows.class_id = assignment_rows.class_id
JOIN people student ON student.id = enrollment_rows.student_id
LEFT JOIN submissions submission_rows
  ON submission_rows.assignment_id = assignment_rows.id
 AND submission_rows.student_id = student.id
WHERE assignment_rows.id = 501
ORDER BY student.name;

CREATE VIEW class_8a_math_lesson_9001_attendance AS
SELECT student.name AS student_name, attendance_rows.status
FROM lessons lesson_rows
JOIN attendance attendance_rows ON attendance_rows.lesson_id = lesson_rows.id
JOIN people student ON student.id = attendance_rows.student_id
WHERE lesson_rows.id = 9001
ORDER BY student.name;

