-- Response types for postal codes geocoder
CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_place_country_iso_v1 AS (q TEXT, c TEXT, iso3 TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_namedplace_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_postalint_country_v1 AS (q INT, c TEXT, geom GEOMETRY, success BOOLEAN);
