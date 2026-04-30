DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='forge_pg_writer') THEN CREATE ROLE forge_pg_writer; END IF; END $$;
CREATE TABLE tenant_notes(id int PRIMARY KEY, workspace text NOT NULL, body text NOT NULL);
ALTER TABLE tenant_notes ENABLE ROW LEVEL SECURITY;
CREATE POLICY note_read ON tenant_notes FOR SELECT TO forge_pg_writer USING (workspace=current_setting('app.workspace',true));
CREATE POLICY note_write ON tenant_notes FOR INSERT TO forge_pg_writer WITH CHECK (workspace=current_setting('app.workspace',true));
CREATE POLICY note_update ON tenant_notes FOR UPDATE TO forge_pg_writer USING (workspace=current_setting('app.workspace',true)) WITH CHECK (workspace=current_setting('app.workspace',true));
GRANT USAGE ON SCHEMA public TO forge_pg_writer;
GRANT SELECT,INSERT,UPDATE ON tenant_notes TO forge_pg_writer;
