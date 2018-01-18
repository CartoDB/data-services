UPDATE global_province_polygons
  SET synonyms = array_append(array_remove(synonyms, 'hsinchu'), 'hsinchu county'),
      "name" = 'Hsinchu County'
  WHERE adm1_code = 'TWN-1162';
