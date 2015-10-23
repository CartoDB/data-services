-- Complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "ALTER EXTENSION cdb_geocoder_admin0 UPDATE TO '0.0.1'" to load this file. \quit

DROP FUNCTION geocode_admin0_polygons(name text);
DROP FUNCTION admin0_synonym_lookup(name text);
