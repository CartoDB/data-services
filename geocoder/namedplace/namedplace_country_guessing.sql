-- Return a guess about the country where the places are located, if possible.
-- E.g: SELECT namedplace_guess_country(Array['granada', 'jaen', 'cordoba', 'madrid', 'valladolid']); => NULL
-- E.g: SELECT namedplace_guess_country(Array['granada', 'jaén', 'córdoba', 'madrid', 'valladolid', 'peligros'])); => 'ES'
CREATE OR REPLACE FUNCTION namedplace_guess_country(places text[])
RETURNS text AS $$
DECLARE
  country_code text;
  threshold CONSTANT float := 0.8;
  input_length integer := array_length(places, 1);
BEGIN
  BEGIN
    WITH hist AS (
        SELECT count(DISTINCT(lower(p.s), gp.iso2)) AS c, iso2
        FROM global_cities_points_limited gp
        inner join (SELECT unnest(places) AS s) p
        ON (gp.lowername = lower(s))
        GROUP BY iso2
      ),
      best_two AS (
        SELECT iso2, c
          FROM hist
          WHERE c > input_length * threshold
          ORDER BY c DESC
          LIMIT 2
      )
    SELECT iso2 INTO STRICT country_code
      FROM (SELECT iso2, c, max(c) over() AS maxcount FROM best_two) bt
      WHERE bt.c = bt.maxcount;
    EXCEPTION
      WHEN NO_DATA_FOUND OR too_many_rows THEN
        RETURN NULL;
  END;
  RETURN country_code;
END;
$$ LANGUAGE 'plpgsql' SECURITY DEFINER IMMUTABLE;
