CREATE EXTENSION postgis;
CREATE EXTENSION schema_triggers;
CREATE EXTENSION plpythonu;
CREATE EXTENSION cartodb;
CREATE EXTENSION cdb_geocoder_admin0;

-- Check that the synonym function is callable, should return NULL
SELECT (admin0_synonym_lookup(Array['United States', 'ESP'])).*;

-- Check that the geocoding function is callable, should return success = false
SELECT (geocode_admin0_polygons(Array['Spain', 'USA', ''])).*;

-- Mock the varnish invalidation function
CREATE OR REPLACE FUNCTION public.cdb_invalidate_varnish(table_name text) RETURNS void AS $$
BEGIN
  RETURN;
END
$$
LANGUAGE plpgsql;

-- Add a few synonyms
COPY admin0_synonyms (name, rank, created_at, updated_at, the_geom, the_geom_webmercator, cartodb_id, adm0_a3, name_) FROM stdin;
United States	0	2014-09-30 10:13:28.383426+00	2014-09-30 10:13:28.383426+00	\N	\N	29614	USA	unitedstates
ESP	3	2014-09-30 10:13:28.383426+00	2014-09-30 10:13:28.383426+00	\N	\N	30146	ESP	esp
Wallis-et-Futuna	2	2014-09-30 10:13:28.383426+00	2014-09-30 10:13:28.383426+00	\N	\N	30013	\N	wallisetfutuna
\.

-- Check that the synonym function is callable, should return their iso codes
SELECT (admin0_synonym_lookup(Array['United States', 'ESP'])).*;
