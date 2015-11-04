CREATE EXTENSION postgis;
CREATE EXTENSION schema_triggers;
CREATE EXTENSION plpythonu;
CREATE EXTENSION cartodb;
CREATE EXTENSION cdb_geocoder_namedplaces;

-- Check that the different geocoding functions are callable, should return success = false
SELECT (geocode_namedplace(Array['Madrid', 'New York City', 'sunapee'])).*;
SELECT (geocode_namedplace(Array['Elche', 'Granada', 'Madrid'], 'Spain')).*;
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City', 'Madrid'], Array['', 'US', 'United States', NULL])).*;
SELECT (geocode_namedplace(Array['Portland', 'Portland', 'New York City'], Array['Maine',    'Oregon',    NULL], 'USA')).*;
SELECT (geocode_namedplace(Array['Portland'], 'Oregon', 'USA')).*;
SELECT (geocode_namedplace(Array['Portland', 'Portland', 'New York City'], Array['Maine',    'Oregon',    NULL], Array['USA'])).*


-- Mock the varnish invalidation function
CREATE OR REPLACE FUNCTION public.cdb_invalidate_varnish(table_name text) RETURNS void AS $$
BEGIN
  RETURN;
END
$$
LANGUAGE plpgsql;

-- Add a named place source
INSERT INTO global_cities_alternates_limited(name, preferred, geoname_id, lowername, iso2, admin1, admin1_geonameid) VALUES (
  'Barcelona',
  't',
  3128760,
  'barcelona', 
  'ES',
  '56',
  409419
);

INSERT INTO global_cities_points_limited(name, geoname_id, asciiname, featclass, featcode, iso2, admin1, admin2, population, the_geom, lowername) VALUES(
  'Barcelona',
  2421056,
  'Barcelona', 
  'P',
  'PPLA',
  'ES',
  'B',
  '185',
  234234,
  '0101000020E6100000CA15DEE522E653C0A4C2D842902B4540',
  'barcelona'
)
-- Check that the geocoding function is callable, should return success = true
SELECT (geocode_namedplace(Array['Barcelona'])).geom;

