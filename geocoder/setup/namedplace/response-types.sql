-- Response types for namedplaces geocoder
CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin1_country_v1 AS (a1 TEXT, c TEXT, q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_namedplace_country_v1 AS (c TEXT, q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin_country_v1 AS (c TEXT, q TEXT, geom GEOMETRY, success BOOLEAN);
