-- A profile is true one-to-one: exactly one profile row can describe a user.
CREATE TABLE user_profiles (
  user_id integer PRIMARY KEY REFERENCES users(id),
  display_name text NOT NULL,
  bio text NOT NULL DEFAULT ''
);
INSERT INTO user_profiles (user_id, display_name, bio) VALUES
  (1,'Ada','Models data carefully'),(2,'Ben','Reads query plans later'),(3,'Cy','Tests edge cases'),(4,'Diya','Keeps examples honest');

