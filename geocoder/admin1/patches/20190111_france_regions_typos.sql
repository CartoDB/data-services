UPDATE global_province_polygons
  SET synonyms = array_append(array_remove(synonyms, 'meurhe-et-moselle'), 'meurthe-et-moselle'),
      "name" = 'Meurthe-et-Moselle'
  WHERE adm1_code = 'FRA-5325';

UPDATE global_province_polygons
  SET synonyms = array_append(array_remove(synonyms, 'seien-et-marne'), 'seine-et-marne'),
      "name" = 'Seine-et-Marne'
  WHERE adm1_code = 'FRA-5342';
