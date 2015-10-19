-- Index on admin1 id
CREATE UNIQUE INDEX idx_qs_adm1_global_id ON qs_adm1 (global_id)
CREATE INDEX idx_admin1_synonyms_name_adm0 ON admin1_synonyms (name_, adm0_a3)
