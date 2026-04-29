-- Chapter 10 authored dataset: Ada opens matching candidates.
CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE matching_profiles (
  user_id integer PRIMARY KEY REFERENCES users(id),
  age integer NOT NULL CHECK (age >= 18),
  city text NOT NULL,
  active boolean NOT NULL DEFAULT true,
  interests text[] NOT NULL DEFAULT '{}'
);
CREATE TABLE matching_preferences (
  user_id integer PRIMARY KEY REFERENCES users(id),
  min_age integer NOT NULL,
  max_age integer NOT NULL,
  city text,
  CHECK (min_age <= max_age)
);
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY(blocker_id,blocked_id));
INSERT INTO users VALUES (1,'ada'),(2,'ben'),(3,'cy'),(4,'diya'),(5,'noor'),(6,'maya'),(7,'omar');
INSERT INTO matching_profiles VALUES
  (1,30,'Glasgow',true,ARRAY['sql','hiking','coffee']),
  (2,31,'Glasgow',true,ARRAY['sql','coffee','cycling']),
  (3,29,'Glasgow',true,ARRAY['hiking','music']),
  (4,30,'Glasgow',true,ARRAY['sql','art']),
  (5,30,'Glasgow',false,ARRAY['sql','hiking']),
  (6,32,'Glasgow',true,ARRAY['sql','hiking','tea']),
  (7,38,'Edinburgh',true,ARRAY['sql','coffee']);
INSERT INTO matching_preferences VALUES
  (1,27,35,'Glasgow'),(2,27,35,'Glasgow'),(3,25,35,'Glasgow'),(4,27,35,'Glasgow'),
  (5,27,35,'Glasgow'),(6,27,35,'Glasgow'),(7,27,45,NULL);
INSERT INTO blocks VALUES (1,4);

