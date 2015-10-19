-- Create indexes on synonyms table
CREATE INDEX idx_admin0_synonyms_name_patt ON admin0_synonyms (name_ text_pattern_ops);
--CREATE INDEX idx_admin0_synonyms_name ON admin0_synonyms (lower(regexp_replace(name, '\W+'::text, ''::text)));
CREATE INDEX idx_admin0_synonyms_name_ ON admin0_synonyms (name_);
--CREATE INDEX idx_admin0_synonyms_nam ON admin0_synonyms (name);
CREATE INDEX idx_admin0_synonyms_rank ON admin0_synonyms (rank);
CREATE INDEX idx_admin0_synonyms_name_rank ON admin0_synonyms (name_, rank);

-- Create indexes on polygon table
CREATE UNIQUE INDEX idx_ne_admin0_v3_adm0_a3 ON ne_admin0_v3 (adm0_a3);
