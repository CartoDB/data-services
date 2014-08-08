--CREATE TYPE geocode_admin_v1 AS (q TEXT, geom GEOMETRY, success BOOLEAN);

CREATE OR REPLACE FUNCTION geocode_admin0_polygons(name text[])
  RETURNS SETOF geocode_admin_v1 AS $$
  DECLARE 
    ret geocode_admin_v1%rowtype;
  BEGIN
  -- FOR ret IN
  RETURN QUERY
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm0_a3 IS NULL then FALSE ELSE TRUE END AS success FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
