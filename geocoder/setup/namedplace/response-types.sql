-- Response types for namedplaces geocoder
CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin1_country_v1 AS (q TEXT, a1 TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_namedplace_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
