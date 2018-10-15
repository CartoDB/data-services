DO $$
  DECLARE updated INTEGER;
BEGIN
  SELECT count(*) FROM admin0_synonyms WHERE adm0_a3 = 'SWZ' GROUP BY adm0_a3 HAVING count(*) > 0 INTO updated;
  IF updated = 4 THEN
    INSERT INTO admin0_synonyms (name, rank, adm0_a3, name_) SELECT 'Eswatini' as name, 6, adm0_a3, 'eswatini' as name_ FROM admin0_synonyms WHERE name_ = 'swaziland';
    INSERT INTO admin0_synonyms (name, rank, adm0_a3, name_) SELECT 'Kingdom of Eswatini' as name, 7, adm0_a3, 'kingdomofeswatini' as name_ FROM admin0_synonyms WHERE name_ = 'swaziland';
  END IF;
END$$;
