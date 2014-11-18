CREATE EXTENSION IF NOT EXISTS unaccent SCHEMA public;


--- This is intended to replace the regexp_replace everywhere a text is compared
--- looking for a synonym.
--- E.g:
--- SELECT * FROM table WHERE normalize(name) = normalize('España')

CREATE OR REPLACE FUNCTION normalize(name text)
  RETURNS text AS $$
BEGIN
  RETURN unaccent(lower(regexp_replace(name, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g')));
END
$$ LANGUAGE 'plpgsql';
