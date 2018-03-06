-- Patch 0.0.1 data version -20160622
DO $$
    DECLARE exiting INTEGER;
BEGIN
    SELECT count(*) FROM admin0_synonyms WHERE name = 'Republic of the Congo' AND adm0_a3 = 'COG' and rank = 10 INTO exiting;
    IF exiting = 0 THEN
        INSERT INTO admin0_synonyms (name, rank, adm0_a3) VALUES ('Republic of the Congo', 10, 'COG');
    END IF;
END$$;
