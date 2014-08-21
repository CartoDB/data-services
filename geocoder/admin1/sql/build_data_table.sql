---- ADMIN1 Geometry Table -----
-------------------------------
--- NOTE ---
-- for countries that have admin1 regions we use data from qs_adm1_region
--------------------------------------------------------------

--- add column global_id to admin1 and admin1 region tables
--- only do this if they don't exist:
--ALTER TABLE qs_adm1 ADD COLUMN global_id INT;
--ALTER TABLE qs_adm1_region ADD COLUMN global_id INT;

--- create a unique id for both the adm1 and adm1_region tables
--- first create new table in memory
--- use the cartodb_id with the table name
WITH all_data AS (
  SELECT cartodb_id AS source_id, 'qs_adm1' AS sourcetable FROM qs_adm1
  UNION ALL
  SELECT cartodb_id AS source_id, 'qs_adm1_region' AS sourcetable FROM qs_adm1_region
), 
--- create a unique global id for data from both tables
global_id AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY source_id ASC) id FROM all_data
),
--- update both tables globa_id column
first_update AS (
    UPDATE qs_adm1 SET global_id = (
        SELECT id FROM global_id WHERE source_id = qs_adm1.cartodb_id AND sourcetable ='qs_adm1'
         ) 
    RETURNING cartodb_id
    )
    UPDATE qs_adm1_region SET global_id = (
        SELECT id FROM global_id WHERE source_id = qs_adm1_region.cartodb_id AND sourcetable ='qs_adm1_region'
         );

-- clear all existing data from the table 
DELETE FROM adm1;

-- insert data from quattro shapes adm1 where countries don't have Regions
INSERT INTO adm1 (the_geom, global_id)
    SELECT the_geom, global_id
    FROM qs_adm1
    WHERE  qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

-- insert data from quattro shapes adm1 regions
INSERT INTO adm1 (the_geom, global_id)
  SELECT the_geom, global_id
  FROM qs_adm1_region;


-- synonyms table = rank, isoCode, id, name, name_code