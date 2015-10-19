-- create indexes on postal code polygon table
CREATE UNIQUE INDEX idx_postal_code_polygons_a3_code ON postal_code_polygons (adm0_a3, postal_code)
