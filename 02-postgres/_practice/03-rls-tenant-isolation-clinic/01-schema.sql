DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='forge_pg_practice_user') THEN CREATE ROLE forge_pg_practice_user; END IF; END $$;
CREATE TABLE tenant_rows(id int PRIMARY KEY, workspace text NOT NULL, title text NOT NULL);
ALTER TABLE tenant_rows ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_rows_read ON tenant_rows FOR SELECT TO forge_pg_practice_user USING (workspace=current_setting('app.workspace',true));
GRANT USAGE ON SCHEMA public TO forge_pg_practice_user;
GRANT SELECT ON tenant_rows TO forge_pg_practice_user;
