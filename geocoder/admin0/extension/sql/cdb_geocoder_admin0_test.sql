CREATE EXTENSION postgis;
CREATE EXTENSION schema_triggers;
CREATE EXTENSION plpythonu;
CREATE EXTENSION cartodb;
CREATE EXTENSION cdb_geocoder_admin0;

-- Check that the synonym function is callable, should return NULL
SELECT (admin0_synonym_lookup(Array['United States', 'ESP'])).*;

-- Check that the geocoding function is callable, should return success = false
SELECT (geocode_admin0_polygons(Array['Spain', 'USA', ''])).*;
