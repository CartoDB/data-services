-- Cleaning function
CREATE OR REPLACE FUNCTION geocode_clean_name(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
  BEGIN
    RETURN regexp_replace(name, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g');
  END
$$;
