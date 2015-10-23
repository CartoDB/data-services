-- Complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "ALTER EXTENSION cdb_geocoder_admin0 UPDATE TO '0.0.2'" to load this file. \quit

-- For the new geocoder, without using arrays
CREATE OR REPLACE FUNCTION geocode_admin0_polygons(name text)
  RETURNS Geometry AS $$
  DECLARE
    ret Geometry;
  BEGIN
    SELECT n.the_geom as geom
      FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x
        FROM (SELECT name q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x
      LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3 GROUP BY d.q, n.the_geom, s.adm0_a3
    INTO ret;

    RETURN ret;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;


-- For the new geocoder, without using arrays
CREATE OR REPLACE FUNCTION admin0_synonym_lookup(name text)
 RETURNS text AS $$
 DECLARE
   ret text;
 BEGIN
    SELECT s.adm0_a3
      FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x
        FROM (SELECT name q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x GROUP BY d.q, s.adm0_a3
    INTO STRICT ret;

    RETURN ret;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
