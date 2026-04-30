CREATE TABLE people (
  id integer PRIMARY KEY,
  name text NOT NULL,
  role text NOT NULL CHECK (role IN ('student', 'teacher', 'admin'))
);

CREATE TABLE subjects (
  id integer PRIMARY KEY,
  name text NOT NULL UNIQUE
);

CREATE TABLE classes (
  id integer PRIMARY KEY,
  name text NOT NULL UNIQUE,
  primary_teacher_id integer REFERENCES people(id)
);

CREATE TABLE class_enrollments (
  class_id integer NOT NULL REFERENCES classes(id),
  student_id integer NOT NULL REFERENCES people(id),
  PRIMARY KEY (class_id, student_id)
);

CREATE TABLE teaching_assignments (
  class_id integer NOT NULL REFERENCES classes(id),
  subject_id integer NOT NULL REFERENCES subjects(id),
  teacher_id integer NOT NULL REFERENCES people(id),
  PRIMARY KEY (class_id, subject_id, teacher_id)
);

CREATE TABLE assignments (
  id integer PRIMARY KEY,
  class_id integer NOT NULL REFERENCES classes(id),
  subject_id integer NOT NULL REFERENCES subjects(id),
  title text NOT NULL
);

CREATE TABLE submissions (
  assignment_id integer NOT NULL REFERENCES assignments(id),
  student_id integer NOT NULL REFERENCES people(id),
  submitted_at timestamp NOT NULL,
  PRIMARY KEY (assignment_id, student_id)
);

CREATE TABLE lessons (
  id integer PRIMARY KEY,
  class_id integer NOT NULL REFERENCES classes(id),
  subject_id integer NOT NULL REFERENCES subjects(id),
  teacher_id integer NOT NULL REFERENCES people(id)
);

CREATE TABLE attendance (
  lesson_id integer NOT NULL REFERENCES lessons(id),
  student_id integer NOT NULL REFERENCES people(id),
  status text NOT NULL CHECK (status IN ('present', 'absent')),
  PRIMARY KEY (lesson_id, student_id)
);

