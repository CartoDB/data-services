---- ADMIN1 SYNONYM TABLE BUILD -----
-------------------------------------
--- synonyms table, each row gets a rank, isoCode, id, 
--- use the following fields from quattro shapes admin1: name, name_code
--- TO DO: add more synonyms from external sources later

--- clear the table
DELETE FROM admin1_synonyms_qs;

--- add admin1 name from qs_adm1 countries that don't have regions
INSERT INTO admin1_synonyms_qs(name, rank, adm0_a3, global_id)
SELECT
    qs_a1, 0, qs_adm0_a3, global_id
FROM
    qs_adm1
WHERE
    qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

--- add province code from qs_adm1 countries that don't have regions
INSERT INTO admin1_synonyms_qs(name, rank, adm0_a3, global_id)
SELECT
    qs_a1_lc, 1, qs_adm0_a3, global_id
FROM
    qs_adm1
WHERE
    qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

--- add admin1 name from qs_adm1_region
INSERT INTO admin1_synonyms_qs(name, rank, adm0_a3, global_id)
SELECT
    qs_a1, 0, qs_adm0_a3, global_id
FROM
    qs_adm1_region;

--- add province code from qs_adm1_region
INSERT INTO admin1_synonyms_qs(name, rank, adm0_a3, global_id)
SELECT
    qs_a1_lc, 1, qs_adm0_a3, global_id
FROM
    qs_adm1_regions;

--- TO DO: add external synonyms