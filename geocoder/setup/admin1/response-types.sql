-- Response types for admin1 geocoder

CREATE TYPE geocode_admin_v1 AS (
    q text,
    geom geometry,
    success boolean
);


CREATE TYPE geocode_admin_country_v1 AS (
    q text,
    c text,
    geom geometry,
    success boolean
);
