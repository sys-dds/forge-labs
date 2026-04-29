-- Matching starts with active profiles and preferences before algorithms are involved.
-- Barbara is intentionally unswiped, active, in Ada's city, and shares an
-- interest so the candidate and preference-fit queries have a positive row.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE matching_profiles (user_id integer PRIMARY KEY REFERENCES users(id), age integer NOT NULL CHECK(age >= 18), city text NOT NULL, active boolean NOT NULL DEFAULT true, interests text[] NOT NULL DEFAULT '{}');
CREATE TABLE matching_preferences (user_id integer PRIMARY KEY REFERENCES users(id), min_age integer NOT NULL, max_age integer NOT NULL, city text, CHECK(min_age <= max_age));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY(blocker_id,blocked_id));
INSERT INTO users (handle) VALUES ('ada'),('grace'),('linus'),('margaret'),('donald'),('barbara');
INSERT INTO matching_profiles VALUES
  (1,30,'London',true,ARRAY['sql','systems']),
  (2,31,'London',true,ARRAY['sql','compilers']),
  (3,45,'Helsinki',true,ARRAY['systems']),
  (4,29,'London',true,ARRAY['sql','math']),
  (5,35,'London',false,ARRAY['sql']),
  (6,32,'London',true,ARRAY['sql','systems','teaching']);
INSERT INTO matching_preferences VALUES (1,25,40,'London'),(2,25,40,'London'),(3,25,50,NULL),(4,25,35,'London'),(5,25,40,'London'),(6,25,40,'London');
INSERT INTO blocks VALUES (1,3);
