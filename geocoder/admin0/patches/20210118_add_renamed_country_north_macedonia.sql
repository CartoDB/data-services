DO $$
  DECLARE updated INTEGER;
BEGIN
  SELECT count(*) FROM admin0_synonyms WHERE adm0_a3 = 'MKD' GROUP BY adm0_a3 HAVING count(*) > 0 INTO updated;
  IF updated = 6 THEN
    INSERT INTO admin0_synonyms (name, rank, adm0_a3, name_) SELECT 'North Macedonia' as name, 6, adm0_a3, 'northmacedonia' as name_ FROM admin0_synonyms WHERE name_ = 'macedonia';
    INSERT INTO admin0_synonyms (name, rank, adm0_a3, name_) SELECT 'Republic of North Macedonia' as name, 7, adm0_a3, 'republicofnorthmacedonia' as name_ FROM admin0_synonyms WHERE name_ = 'macedonia';
  END IF;
END$$;
