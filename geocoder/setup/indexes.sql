-- create indexes on synonyms table
CREATE INDEX idx_admin0_synonyms_name_patt ON admin0_synonyms (name_ text_pattern_ops);
CREATE INDEX idx_admin0_synonyms_name_ ON admin0_synonyms (name_);
CREATE INDEX idx_admin0_synonyms_rank ON admin0_synonyms (rank);
-- CREATE INDEX idx_admin0_synonyms_name_rank ON admin0_synonyms (name_, rank);

-- Index on admin1 id
CREATE UNIQUE INDEX idx_qs_adm1_global_id ON qs_adm1 (global_id)
CREATE INDEX idx_admin1_synonyms_name_adm0 ON admin1_synonyms (name_, adm0_a3)

-- create indexes on polygon table
CREATE UNIQUE INDEX idx_ne_admin0_v3_adm0_a3 ON ne_admin0_v3 (adm0_a3);

-- create indexes on postal code polygon table
CREATE UNIQUE INDEX idx_postal_code_polygons_a3_code ON postal_code_polygons (adm0_a3, postal_code)

-- create indexes on named places table
CREATE INDEX idx_global_cities_points_limited_a ON global_cities_points_limited (lowername, iso2)
CREATE INDEX idx_global_cities_points_limited_admin1 ON global_cities_points_limited (admin1)
CREATE INDEX idx_global_cities_points_limited_geoname_id ON global_cities_points_limited (geoname_id)

CREATE INDEX idx_global_cities_alternates_limited_admin1 ON global_cities_alternates_limited (admin1)
CREATE INDEX idx_global_cities_alternates_limited_admin1_geonameid ON global_cities_alternates_limited (admin1_geonameid)
CREATE INDEX idx_global_cities_alternates_limited_lowername ON global_cities_alternates_limited (lowername)
