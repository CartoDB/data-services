---- ADMIN1 SYNONYM TABLE BUILD -----
-------------------------------------
--- synonyms table, each row gets a rank, isoCode, id, 
--- use the following fields from quattro shapes admin1: name, name_code
--- TO DO: add more synonyms from external sources later

--- clear the table
DELETE FROM admin1_synonyms;

--- add admin1 name from qs_adm1 countries that don't have regions
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id)
SELECT
    qs_a1, 0, qs_adm0_a3, global_id
FROM
    qs_adm1
WHERE
    qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

--- add province code from qs_adm1 countries that don't have regions
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id)
SELECT
    qs_a1_lc, 1, qs_adm0_a3, global_id
FROM
    qs_adm1
WHERE
    qs_adm0 NOT IN ('Belgium', 'Finland', 'France', 'Hungary', 'Italy', 'Serbia', 'Spain', 'United Kingdom');

--- add admin1 name from qs_adm1_region
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id)
SELECT
    qs_a1r, 0, qs_adm0_a3, global_id
FROM
    qs_adm1_region;


-------- add external synonyms from natural earth admin1 states provinces --------
-- separate data from the name_alt column from ne_admin1_v3 using `|` as a delimiter and insert into admin1_synonyms as new rows with a rank=2
INSERT INTO admin1_synonyms (name, rank, adm0_a3, global_id) 
SELECT 
    regexp_split_to_table(ne_admin1_v3.name_alt, E'\\|' ) AS name,
    2, adm0_a3, 
        (
        SELECT qs_adm1.global_id FROM qs_adm1 
        WHERE qs_source = 'Natural Earth' 
        AND ne_admin1_v3.adm1_code = qs_a1_lc
        )
FROM
    ne_admin1_v3
WHERE adm1_code IN (
    SELECT qs_a1_lc 
    FROM qs_adm1 
    WHERE qs_source = 'Natural Earth'
);

-- add the abbrev as a rank = 3
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id )
SELECT abbrev, 3, adm0_a3,
        (
        SELECT qs_adm1.global_id FROM qs_adm1 
        WHERE qs_source = 'Natural Earth' 
        AND ne_admin1_v3.adm1_code = qs_a1_lc
        )
FROM
    ne_admin1_v3
WHERE adm1_code IN (
    SELECT qs_a1_lc 
    FROM qs_adm1 
    WHERE qs_source = 'Natural Earth'
);

-- add the postal code as rank = 4
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id)
SELECT postal, 4, adm0_a3, 
        (
        SELECT qs_adm1.global_id FROM qs_adm1 
        WHERE qs_source = 'Natural Earth' 
        AND ne_admin1_v3.adm1_code = qs_a1_lc
        )
FROM
    ne_admin1_v3
WHERE adm1_code IN (
    SELECT qs_a1_lc 
    FROM qs_adm1 
    WHERE qs_source = 'Natural Earth'
);

-- add gn_name as rank = 5
INSERT INTO admin1_synonyms(name, rank, adm0_a3, global_id)
SELECT postal, 4, adm0_a3, 
        (
        SELECT qs_adm1.global_id FROM qs_adm1 
        WHERE qs_source = 'Natural Earth' 
        AND ne_admin1_v3.adm1_code = qs_a1_lc
        )
FROM
    ne_admin1_v3
WHERE adm1_code IN (
    SELECT qs_a1_lc 
    FROM qs_adm1 
    WHERE qs_source = 'Natural Earth'
);

-- remove all cases where name is NULL
DELETE FROM admin1_synonyms WHERE name IS NULL;

-- remove all cases where a name is duplicated with a higher rank
DELETE FROM admin1_synonyms 
    WHERE cartodb_id IN (
        SELECT 
            cartodb_id 
        FROM 
            admin1_synonyms a 
        WHERE 
            0 < (
                SELECT count(*) 
                FROM admin1_synonyms 
                WHERE name_ = a.name_ 
                  AND global_id = a.global_id 
                  AND rank < a.rank));
