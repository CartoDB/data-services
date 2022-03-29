UPDATE global_province_polygons
  SET synonyms = array_append(array_remove(synonyms, 'haut-rhin'), 'haut-rhin')
  WHERE adm1_code = 'FRA-5296';
