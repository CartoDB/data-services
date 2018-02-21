CREATE OR REPLACE FUNCTION geocode_admin0_polygons(name text[])
  RETURNS SETOF geocode_admin_v1 AS $$
  DECLARE
    ret geocode_admin_v1%rowtype;
  BEGIN
  -- FOR ret IN
  RETURN QUERY
    SELECT d.q, n.the_geom as geom, CASE WHEN s.adm0_a3 IS NULL then FALSE ELSE TRUE END AS success
      FROM (SELECT q, lower(geocode_clean_name(q))::text x
        FROM (SELECT unnest(name) q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x
      LEFT OUTER JOIN ne_admin0_v3 n ON s.adm0_a3 = n.adm0_a3 GROUP BY d.q, n.the_geom, s.adm0_a3;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

CREATE OR REPLACE FUNCTION admin0_synonym_lookup(name text[])
 RETURNS SETOF synonym_lookup_v1 AS $$
 DECLARE
    ret synonym_lookup_v1%rowtype;
 BEGIN  RETURN QUERY
    SELECT d.q, s.adm0_a3
      FROM (SELECT q, lower(geocode_clean_name(q))::text x
        FROM (SELECT unnest(name) q) g) d
      LEFT OUTER JOIN admin0_synonyms s ON name_ = d.x GROUP BY d.q, s.adm0_a3;
END
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

CREATE OR REPLACE FUNCTION geocode_namedplace(places text[], admin1s text[], inputcountry text[]) RETURNS SETOF geocode_admin1_country_v1
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
  DECLARE
    ret geocode_admin1_country_v1%rowtype;
  BEGIN
    IF admin1s IS NULL THEN
      FOR ret IN SELECT g.q as q, NULL as a1, g.c as c, g.geom as geom, g.success as success FROM (SELECT (geocode_namedplace(places, inputcountry)).*) g LOOP
          RETURN NEXT ret;
      END LOOP;
    ELSE
      FOR ret IN WITH clean AS (SELECT array_agg(p) p, array_agg(a) a, c FROM (SELECT p, a, c FROM (SELECT unnest(places) p, unnest(admin1s) a, unnest(inputcountry) c) z GROUP BY p, a, c) y GROUP BY c)
        SELECT (geocode_namedplace(p, a, c)).* FROM clean LOOP
          RETURN NEXT ret;
      END LOOP;
    END IF;
  RETURN;
END
$$;
