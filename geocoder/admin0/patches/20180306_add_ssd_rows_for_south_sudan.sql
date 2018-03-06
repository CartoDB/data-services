DO $$
  DECLARE updated INTEGER;
BEGIN
  SELECT count(*) FROM admin0_synonyms WHERE adm0_a3 = 'SSD' INTO updated;
  IF updated = 0 THEN
    INSERT INTO admin0_synonyms (name, rank, adm0_a3, name_) SELECT name, rank, 'SSD' AS adm0_a3, name_ FROM admin0_synonyms WHERE adm0_a3 = 'SDS';
  END IF;
END$$;
