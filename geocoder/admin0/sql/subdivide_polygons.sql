---- Subdivide France and Norway into subregions ----
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

-- Split Martinique from France

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(14.60, -60.89)))

SELECT ST_Collect(geom), 'MTQ', 'Martinique'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(14.60, -60.89),0.5));

-- Split Mayotte from France

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-12.72, 45.18)))

SELECT ST_Collect(geom), 'MYT', 'Mayotte'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-12.72, 45.18),0.5));

-- Split Guadeloupe from France

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(15.95, -61.30)))

SELECT ST_Collect(geom), 'GLP', 'Guadeloupe'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(15.95, -61.30),0.5));

-- Remove the Martinique and Mayotte from the FRA polygon

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'FRA')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 IN ('MTQ', 'MYT', 'GLP')))) WHERE adm0_a3 = 'FRA';

---- Subdivide Norway into subregions ----
-- Split Bouvet Island from Norway

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-54.45, 3.37)))

SELECT geom, 'BVT', 'Bouvet Island'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-54.45, 3.37), 2));

-- Remove the Bouvet Island from the NOR polygon

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'NOR')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 = 'BVT'))) WHERE adm0_a3 = 'NOR';

-- Split Svalbard and Jan Mayen from Norway

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3)

SELECT ST_Collect(geom), 'SJM', 'Svalbard and Jan Mayen' FROM a WHERE ST_Intersects(geom, ST_MakeEnvelope(8, 90, 30, 75, 4326));

-- Split Svalbard from region NOR

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'NOR')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 = 'SJM'))) WHERE adm0_a3 = 'NOR';

---- Subdivide IOA NE iso3 code into subregions ----
-- Split Cocos (Keeling) Islands from region IOA

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-12.18, 96.914)))

SELECT ST_union(geom), 'CCK', 'Cocos (Keeling) Islands' FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-12.18, 96.914), 1));

-- Split Christmas Island from region IOA

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-10.50, 105.60)))

SELECT geom, 'CXR', 'Christmas Island'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-10.50, 105.60), 1));


---- Subdivide Netherlands into subregions ----
-- Split Bonaire (Sint Eustatius and Saba) from Norway

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(12.1991, -68.2649)))

SELECT ST_Collect(geom), 'BES', 'Bonaire (Sint Eustatius and Saba)'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(12.1991, -68.2649),0.3));

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'NLD')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 = 'BES'))) WHERE adm0_a3 = 'NLD';


---- Subdivide Tokelau polygon from American Samoa (independent since 2006) ----

INSERT INTO ne_admin0_v3 (the_geom, adm0_a3, name)

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom,adm0_a3  FROM ne_admin0_v3 WHERE ST_Intersects(the_geom, CDB_LatLNg(-11.06, -171.08)))

SELECT ST_Collect(geom), 'TKL', 'Tokelau'  FROM a WHERE ST_Intersects(geom, ST_Buffer(CDB_LatLNg(-11.06, -171.08),0.2));

-- Remove Tokelau from the ASM polygon

WITH a AS (SELECT (ST_Dump(the_geom)).geom geom  FROM ne_admin0_v3 WHERE adm0_a3 = 'ASM')
UPDATE ne_admin0_v3 SET the_geom = (SELECT ST_Union(geom) FROM a WHERE NOT ST_intersects(geom, (SELECT ST_Union(the_geom) FROM ne_admin0_v3 WHERE adm0_a3 = 'TKL'))) WHERE adm0_a3 = 'ASM';
