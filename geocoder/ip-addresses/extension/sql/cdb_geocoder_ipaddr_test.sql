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
INSERT INTO ip_address_locations (network_start_ip, the_geom) VALUES ('::ffff:2.235.35.0'::inet, '0101000020E610000072F90FE9B7CF22405DFE43FAEDC34640');
INSERT INTO ip_address_locations (network_start_ip, the_geom) VALUES ('::ffff:31.7.187.0'::inet, '');
INSERT INTO ip_address_locations (network_start_ip, the_geom) VALUES ('::ffff:64.110.146.0'::inet, '');

-- Check that the geocoding function is callable, should return success = true
SELECT (geocode_ip(Array['2.235.35.0'])).geom;
