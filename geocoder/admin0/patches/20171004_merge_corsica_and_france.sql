UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 IN ('FRA', 'FRH')) WHERE adm0_a3 = 'FRA';
DELETE FROM ne_admin0_v3 WHERE adm0_a3 = 'FRH';
