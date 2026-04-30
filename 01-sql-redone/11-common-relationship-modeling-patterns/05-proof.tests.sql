CREATE OR REPLACE FUNCTION fail_test(message text)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION '%', message;
END;
$$;

CREATE TEMP TABLE expected_roster (student_name text);
INSERT INTO expected_roster VALUES ('Ada'), ('Ben');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_roster EXCEPT SELECT student_name FROM class_8a_roster)
  UNION ALL
  (SELECT student_name FROM class_8a_roster EXCEPT SELECT * FROM expected_roster)
) THEN 1 ELSE fail_test('expected Class 8A roster {Ada,Ben}; broken class roster leaked Cy or lost Ada/Ben') END AS class_8a_roster_exact;

CREATE TEMP TABLE expected_teachers (teacher_name text, subject_name text);
INSERT INTO expected_teachers VALUES ('Sarah', 'Math'), ('Omar', 'Science');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_teachers EXCEPT SELECT teacher_name, subject_name FROM class_8a_teaching_assignments)
  UNION ALL
  (SELECT teacher_name, subject_name FROM class_8a_teaching_assignments EXCEPT SELECT * FROM expected_teachers)
) THEN 1 ELSE fail_test('expected Class 8A teachers {Sarah Math,Omar Science}; broken query used class teacher_id or leaked Sarah English') END AS teaching_assignments_exact;

CREATE TEMP TABLE expected_assignment (student_name text, submission_status text);
INSERT INTO expected_assignment VALUES ('Ada', 'submitted'), ('Ben', 'missing');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_assignment EXCEPT SELECT student_name, submission_status FROM math_assignment_501_status)
  UNION ALL
  (SELECT student_name, submission_status FROM math_assignment_501_status EXCEPT SELECT * FROM expected_assignment)
) THEN 1 ELSE fail_test('expected assignment 501 status {Ada submitted,Ben missing}; broken query treated class submission as every student submitted or included Cy') END AS assignment_status_exact;

CREATE TEMP TABLE expected_attendance (student_name text, status text);
INSERT INTO expected_attendance VALUES ('Ada', 'present'), ('Ben', 'absent');

SELECT CASE WHEN NOT EXISTS (
  (SELECT * FROM expected_attendance EXCEPT SELECT student_name, status FROM class_8a_math_lesson_9001_attendance)
  UNION ALL
  (SELECT student_name, status FROM class_8a_math_lesson_9001_attendance EXCEPT SELECT * FROM expected_attendance)
) THEN 1 ELSE fail_test('expected lesson 9001 attendance {Ada present,Ben absent}; broken query leaked Cy Class 8B attendance or other lessons') END AS attendance_exact;

SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM class_8a_roster WHERE student_name = 'Cy') THEN 1 ELSE fail_test('expected Cy excluded from Class 8A roster; broken class scope included Class 8B student Cy') END AS cy_roster_excluded;
SELECT CASE WHEN NOT EXISTS (SELECT 1 FROM math_assignment_501_status WHERE student_name = 'Cy') THEN 1 ELSE fail_test('expected Cy absent from assignment 501 status; broken assignment query included Class 8B student Cy') END AS cy_assignment_excluded;

