-- Check that the different geocoding functions are callable, should return success = false
SELECT (geocode_namedplace(Array['Madrid', 'New York City', 'sunapee'])).*;
SELECT (geocode_namedplace(Array['Elche', 'Granada', 'Madrid'], 'Spain')).*;
SELECT (geocode_namedplace(Array['sunapee', 'sunapeeee', 'New York City', 'Madrid'], Array['', 'US', 'United States', NULL])).*;
SELECT (geocode_namedplace(Array['Portland', 'Portland', 'New York City'], Array['Maine',    'Oregon',    NULL], 'USA')).*;
SELECT (geocode_namedplace(Array['Portland'], 'Oregon', 'USA')).*;
SELECT (geocode_namedplace(Array['Portland', 'Portland', 'New York City'], Array['Maine',    'Oregon',    NULL], Array['USA'])).*;
SELECT namedplace_guess_country(Array['granada', 'jaen', 'cordoba', 'madrid', 'valladolid']);

-- Add a named place source
COPY global_cities_alternates_limited (geoname_id, name, the_geom, created_at, updated_at, the_geom_webmercator, preferred, lowername, cartodb_id, admin1_geonameid, iso2, admin1) FROM stdin;
3128760	barcelona	\N	2014-02-11 18:23:18.115612+00	2014-02-25 16:41:15.278786+00	\N	t	barcelona	7530944	409419	\N	56
\.

COPY global_cities_points_limited (geoname_id, name, asciiname, altnames, featclass, featcode, iso2, admin1, admin2, population, the_geom, created_at, updated_at, the_geom_webmercator, cartodb_id, lowername) FROM stdin;
2421056	Barcelona	Barcelona		P	PPLA	ES	B		185	0101000020E6100000CA15DEE522E653C0A4C2D842902B4540	2015-06-13 14:48:34.341372+00	2015-06-15 16:53:41.067784+00	0101000020110F00000643969A73E660C10FF27276F0E15341	8653176	barcelona
\.

-- Check that the geocoding function is callable, should return success = true
SELECT (geocode_namedplace(Array['Barcelona'])).*;
SELECT namedplace_guess_country(Array['Barcelona']);

