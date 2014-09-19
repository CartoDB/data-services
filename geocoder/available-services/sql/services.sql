--CREATE TYPE available_services_v1 AS (q TEXT, adm0_a3 TEXT, postal_code_points BOOLEAN, postal_code_polygons BOOLEAN);

CREATE OR REPLACE FUNCTION admin0_available_services(countries text[])
  RETURNS SETOF available_services_v1 AS $$
  DECLARE 
    ret available_services_v1%rowtype;
  BEGIN
  -- FOR ret IN
  RETURN QUERY
    SELECT d.q, n.adm0_a3, n.postal_code_points, n.postal_code_polygons FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x LEFT OUTER JOIN available_services n ON s.adm0_a3 = n.adm0_a3 GROUP BY d.q, n.adm0_a3, n.postal_code_points, n.postal_code_polygons;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
