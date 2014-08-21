---- ADMIN1 DATA TABLE BUILD -----
-------------------------------
--- NOTE ---
-- for countries that have admin1 regions we use data from qs_adm1_region
--------------------------------------------------------------

--- only do this step global_id doesn't exist in quattro shapes admin1 datasets:
--- add column global_id to admin1 and admin1 region tables
--ALTER TABLE qs_adm1 ADD COLUMN global_id INT;
--ALTER TABLE qs_adm1_region ADD COLUMN global_id INT;

--- we need to create a unique id for both the adm1 and adm1_region tables
--- first create new table in memory. use the cartodb_id with the table name
WITH all_data AS (
  SELECT cartodb_id AS source_id, 'qs_adm1' AS sourcetable FROM qs_adm1
  UNION ALL
  SELECT cartodb_id AS source_id, 'qs_adm1_region' AS sourcetable FROM qs_adm1_region
), 
--- create a unique global id for data from both tables
global_id AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY source_id ASC) id FROM all_data
),
--- now update both tables' global_id column
first_update AS (
    UPDATE qs_adm1 SET global_id = (
        SELECT id FROM global_id WHERE source_id = qs_adm1.cartodb_id AND sourcetable ='qs_adm1'
         ) 
    RETURNING cartodb_id
    )
    UPDATE qs_adm1_region SET global_id = (
        SELECT id FROM global_id WHERE source_id = qs_adm1_region.cartodb_id AND sourcetable ='qs_adm1_region'
         );

--- punch out ne_10m coastline from the following countries in quattro shapes admin1 data. Do this one at a time to not bog down the cpu.
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'USA';
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'CAN';
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'MEX';
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'SWE';
update qs_adm1_region set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'FIN';
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'HRV';
update qs_adm1 set the_geom = ST_Intersection(the_geom, (SELECT the_geom FROM ne_10m_land)) WHERE qs_adm0_a3 = 'NOR';    

--- clear all existing data from the adm1 table 
DELETE FROM adm1;

--- insert data from quattro shapes adm1 where countries don't have admin1 regions
INSERT INTO adm1 (the_geom, global_id)
    SELECT the_geom, global_id
    FROM qs_adm1
    WHERE  qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

--- insert data from quattro shapes adm1 regions
INSERT INTO adm1 (the_geom, global_id)
  SELECT the_geom, global_id
  FROM qs_adm1_region;
