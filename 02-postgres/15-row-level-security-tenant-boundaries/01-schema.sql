DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='forge_pg_app_user') THEN CREATE ROLE forge_pg_app_user; END IF; END $$;
CREATE TABLE tenant_listings(id int PRIMARY KEY, workspace text NOT NULL, title text NOT NULL);
ALTER TABLE tenant_listings ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_read ON tenant_listings FOR SELECT TO forge_pg_app_user USING (workspace = current_setting('app.workspace', true));
GRANT USAGE ON SCHEMA public TO forge_pg_app_user;
GRANT SELECT ON tenant_listings TO forge_pg_app_user;
