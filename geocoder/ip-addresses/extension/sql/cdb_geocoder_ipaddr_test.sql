CREATE EXTENSION postgis;
CREATE EXTENSION schema_triggers;
CREATE EXTENSION plpythonu;
CREATE EXTENSION cartodb;
CREATE EXTENSION cdb_geocoder_ipaddr;

-- Check that the geocoding function is callable, should return success = false
SELECT (geocode_ip(Array['100.0.24.0'])).*;

-- Mock the varnish invalidation function
CREATE OR REPLACE FUNCTION public.cdb_invalidate_varnish(table_name text) RETURNS void AS $$
BEGIN
  RETURN;
END
$$
LANGUAGE plpgsql;

-- Add a few IP sources
COPY ip_address_locations (network_start_ip, the_geom, cartodb_id, created_at, updated_at, the_geom_webmercator) FROM stdin;
::ffff:2.235.35.0	0101000020E610000072F90FE9B7CF22405DFE43FAEDC34640	2821226	2014-08-25 10:35:51.665546+00	2014-08-25 10:35:51.665546+00	0101000020110F000010801778FBF32F4109868FF8BCC35541
::ffff:31.7.187.0       \N      2783250 2014-08-25 10:35:51.665546+00   2014-08-25 10:35:51.665546+00   \N
::ffff:64.110.146.0     \N      2783251 2014-08-25 10:35:51.665546+00   2014-08-25 10:35:51.665546+00   \N
::ffff:72.5.198.0       \N      2783252 2014-08-25 10:35:51.665546+00   2014-08-25 10:35:51.665546+00   \N
::ffff:77.73.184.0      \N      2783253 2014-08-25 10:35:51.665546+00   2014-08-25 10:35:51.665546+00   \N
\.

-- Check that the geocoding function is callable, should return success = true
SELECT (geocode_ip(Array['2.235.35.0'])).*;
