---- Subdivide France into subregions ----
--- Assumes fresh NaturalEarth admin0 dataset
-- Split French Guiane from France
INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(4, -53)))

SELECT geom, 'GUF', 'French Guiane'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(4, -53), 8));

-- Split Corse from France
INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(42.14, 9.12)))

SELECT ST_Collect(geom), 'FRH', 'Corse'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(42.14, 9.12), 2));

-- Split Reunion from France
INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-21.12, 55.51)))

SELECT ST_Collect(geom), 'REU', 'Reunion'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-21.12, 55.51),2));

-- Remove the above three from the FRA polygon
WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'FRA')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 IN ('GUF', 'FRH', 'REU')))) WHERE adm0_a3 = 'FRA';
