-- Response types for admin1 geocoder
CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin_country_v1 AS (c TEXT, q TEXT, geom GEOMETRY, success BOOLEAN);
