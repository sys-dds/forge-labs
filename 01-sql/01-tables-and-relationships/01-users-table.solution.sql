-- Users are the root identity table for this chapter.
-- A generated primary key gives every later relationship a stable target.
CREATE TABLE users (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  email text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);
INSERT INTO users (handle, email) VALUES ('ada','ada@forge.test'),('grace','grace@forge.test'),('linus','linus@forge.test');
