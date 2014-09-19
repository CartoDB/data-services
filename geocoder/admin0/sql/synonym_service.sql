--CREATE TYPE synonym_lookup_v1 AS (q TEXT, adm0_a3 TEXT);

--EXAMPLE
-- SELECT (admin0_synonym_lookup(Array['United States', 'ESP'])).*

CREATE OR REPLACE FUNCTION admin0_synonym_lookup(name text[])
  RETURNS SETOF synonym_lookup_v1 AS $$
  DECLARE 
    ret synonym_lookup_v1%rowtype;
  BEGIN
  -- FOR ret IN
  RETURN QUERY
    SELECT d.q, n.adm0_a3 FROM (SELECT q, lower(regexp_replace(q, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'))::text x FROM (SELECT unnest(name) q) g) d LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x GROUP BY d.q, n.adm0_a3;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;
