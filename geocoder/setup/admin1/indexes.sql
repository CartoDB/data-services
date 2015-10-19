-- Index on admin1 id
CREATE UNIQUE INDEX idx_qs_adm1_global_id ON qs_adm1 (global_id)

-- Indexes on admin1 synonyms table
CREATE INDEX idx_admin1_synonyms_name_adm0 ON admin1_synonyms (name_, adm0_a3)
CREATE INDEX idx_admin1_synonyms_name ON admin1_synonyms (name)
CREATE INDEX idx_admin1_synonyms_name_ ON admin1_synonyms (name_)
CREATE INDEX idx_admin1_synonyms_rank ON admin1_synonyms (rank)

-- Indexes on admin1 decoder table
CREATE INDEX idx_admin1_decoder_admin1 ON admin1_decoder (admin1)
CREATE INDEX idx_admin1_decoder_geoname_id ON admin1_decoder (geoname_id)
CREATE INDEX idx_admin1_decoder_iso2 ON admin1_decoder (iso2)
CREATE INDEX idx_admin1_decoder_iso3 ON admin1_decoder (iso3)
CREATE INDEX idx_admin1_decoder_name ON admin1_decoder (name)
