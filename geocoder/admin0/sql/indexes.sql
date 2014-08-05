-- create indexes on synonyms table
CREATE INDEX idx_admin0_synonyms_name_ ON admin0_synonyms (name_);
CREATE INDEX idx_admin0_synonyms_rank ON admin0_synonyms (rank);
CREATE INDEX idx_admin0_synonyms_name_rank ON admin0_synonyms (name_, rank);

-- create indexes on polygon table
CREATE INDEX idx_ne_admin0_v3_adm0_a3 ON ne_admin0_v3 (adm0_a3);

