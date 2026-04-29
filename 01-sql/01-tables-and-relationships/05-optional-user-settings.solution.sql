-- Settings are optional one-to-one. Ada has settings; Ben intentionally does not,
-- proving absence of settings is not absence of user identity.
CREATE TABLE user_settings (
  user_id integer PRIMARY KEY REFERENCES users(id),
  email_notifications boolean NOT NULL DEFAULT true,
  dark_mode boolean NOT NULL DEFAULT false
);
INSERT INTO user_settings VALUES (1,true,true);

