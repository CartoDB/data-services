-- Response types for admin0 geocoder
CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE synonym_lookup_v1 AS (q TEXT, adm0_a3 TEXT);
