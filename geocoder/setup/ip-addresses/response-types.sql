-- Response types for IP addresses geocoder
CREATE TYPE geocode_ip_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);
