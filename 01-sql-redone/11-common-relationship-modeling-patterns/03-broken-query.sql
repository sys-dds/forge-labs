CREATE VIEW class_8a_roster AS
SELECT student.name AS student_name
FROM people student
WHERE student.role = 'student'
ORDER BY student.name;

CREATE VIEW class_8a_teaching_assignments AS
SELECT teacher.name AS teacher_name, subject_rows.name AS subject_name
FROM classes class_rows
JOIN people teacher ON teacher.id = class_rows.primary_teacher_id
JOIN teaching_assignments assignment_rows ON assignment_rows.teacher_id = teacher.id
JOIN subjects subject_rows ON subject_rows.id = assignment_rows.subject_id
WHERE class_rows.name = 'Class 8A'
ORDER BY teacher.name, subject_rows.name;

CREATE VIEW math_assignment_501_status AS
SELECT
  student.name AS student_name,
  CASE WHEN EXISTS (SELECT 1 FROM submissions s WHERE s.assignment_id = 501) THEN 'submitted' ELSE 'missing' END AS submission_status
FROM people student
WHERE student.role = 'student'
ORDER BY student.name;

CREATE VIEW class_8a_math_lesson_9001_attendance AS
SELECT student.name AS student_name, attendance_rows.status
FROM classes class_rows
JOIN lessons lesson_rows ON lesson_rows.class_id = class_rows.id
JOIN attendance attendance_rows ON attendance_rows.lesson_id = lesson_rows.id
JOIN people student ON student.id = attendance_rows.student_id
WHERE class_rows.name IN ('Class 8A', 'Class 8B')
ORDER BY student.name;

