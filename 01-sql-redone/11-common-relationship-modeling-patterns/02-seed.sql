INSERT INTO people (id, name, role) VALUES
  (1, 'Ada', 'student'),
  (2, 'Ben', 'student'),
  (3, 'Cy', 'student'),
  (4, 'Sarah', 'teacher'),
  (5, 'Omar', 'teacher'),
  (6, 'Maya', 'admin');

INSERT INTO subjects (id, name) VALUES
  (10, 'Math'),
  (20, 'Science'),
  (30, 'English');

INSERT INTO classes (id, name, primary_teacher_id) VALUES
  (100, 'Class 8A', 4),
  (200, 'Class 8B', 4);

INSERT INTO class_enrollments (class_id, student_id) VALUES
  (100, 1),
  (100, 2),
  (200, 3);

INSERT INTO teaching_assignments (class_id, subject_id, teacher_id) VALUES
  (100, 10, 4),
  (100, 20, 5),
  (200, 30, 4);

INSERT INTO assignments (id, class_id, subject_id, title) VALUES
  (501, 100, 10, 'Math homework 501');

INSERT INTO submissions (assignment_id, student_id, submitted_at) VALUES
  (501, 1, '2026-01-02 09:00:00');

INSERT INTO lessons (id, class_id, subject_id, teacher_id) VALUES
  (9001, 100, 10, 4),
  (9002, 100, 20, 5),
  (9101, 200, 30, 4);

INSERT INTO attendance (lesson_id, student_id, status) VALUES
  (9001, 1, 'present'),
  (9001, 2, 'absent'),
  (9101, 3, 'present');

