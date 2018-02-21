-- Response types for admin0 geocoder
CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE synonym_lookup_v1 AS (q TEXT, adm0_a3 TEXT);

-- Response types for admin1 geocoder
CREATE TYPE geocode_admin_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);

-- Response types for IP addresses geocoder
CREATE TYPE geocode_ip_v1 AS (q text, geom geometry, success boolean);

-- Response types for namedplaces geocoder
CREATE TYPE geocode_namedplace_country_v1 AS (q TEXT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_namedplace_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_admin1_country_v1 AS (q text, a1 text, c text, geom geometry, success boolean);

-- Response types for postalcodes geocoder
CREATE TYPE geocode_postalint_country_v1 AS (q INT, c TEXT, geom GEOMETRY, success BOOLEAN);
CREATE TYPE geocode_place_country_iso_v1 AS (q TEXT, c TEXT, iso3 TEXT, geom GEOMETRY, success BOOLEAN);


CREATE TYPE available_services_v1 AS (q text, adm0_a3 text, postal_code_points boolean, postal_code_polygons boolean);
