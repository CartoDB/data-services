-- create trigger function. used in both admin1 and admin2 synonym tables
CREATE OR REPLACE FUNCTION alpha_numeric_identifiers() RETURNS trigger AS $alpha_numeric_identifiers$
    BEGIN
        NEW.name_ := lower(regexp_replace(NEW.name, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g'));
        RETURN NEW;
    END;
$alpha_numeric_identifiers$ LANGUAGE plpgsql;

-- add trigger on admin0 synonym table name_ column
CREATE TRIGGER admin0_synonyms_name_update
BEFORE INSERT OR UPDATE OF name ON admin0_synonyms 
  FOR EACH ROW EXECUTE PROCEDURE alpha_numeric_identifiers()

-- add trigger on admin1 synonym table name_ column
CREATE TRIGGER admin1_synonyms_name_update
BEFORE INSERT OR UPDATE OF name ON admin1_synonyms 
  FOR EACH ROW EXECUTE PROCEDURE alpha_numeric_identifiers()