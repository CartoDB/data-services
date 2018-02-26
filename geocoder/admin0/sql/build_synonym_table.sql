
---- ADMIN0_SYNONYMS ---
--- ---
--- NOTE ---
--- insert order should be from lowest rank to highest ---
--- this allows us to use table sort order instead of an explicit ORDER BY rank ---
--- in searches and reduces search cost / time ---
--- ---

-- clear all existing data from the table --
DELETE FROM admin0_synonyms;

-- insert data from ne_admin_0 into admin0_synonyms
-- the name column from ne_10m_countries is assigned a rank of 0
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
    SELECT name, 0, iso_a3
    FROM ne_admin0_v3;

-- insert data from ne_admin_0 into admin0_synonyms
-- the name column is assigned a rank of 0 for cases where adm0_a3 is not iso_a3

INSERT INTO admin0_synonyms (name, rank, adm0_a3)
    SELECT iso_a3, 0, iso_a3
    FROM ne_admin0_v3
    WHERE adm0_a3 NOT LIKE iso_a3 AND iso_a3 NOT LIKE '-99';

-- separate data from the name_alt column from ne_admin0_v3 using `|` as a delimiter
-- and insert into admin1_synonyms as new rows with a rank=1
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    regexp_split_to_table(ne_admin0_v3.name_alt, E'\\|' ) AS name, 1, iso_a3
FROM
    ne_admin0_v3;

-- insert ad0_a3  codes as synonyms with a rank = 2
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    country_endonym, 2,  adm0_a3
FROM
    wikipedia_countries_native_names
WHERE
    adm0_a3 IS NOT null;

-- insert ad0_a3  codes as synonyms with a rank = 3
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    adm0_a3, 3,  iso_a3
FROM
    ne_admin0_v3;

    -- insert iso_a2 as name with a rank = 4
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    iso_a2, 4, iso_a3
FROM
    wikipedia_iso_3166_2;

-- insert formal_en as name with a rank = 5
INSERT INTO admin0_synonyms (name, rank,  adm0_a3)
SELECT
    formal_en, 5, iso_a3
FROM
    ne_admin0_v3;

-- insert brk_name as name with a rank = 6
INSERT INTO admin0_synonyms (name, rank,  adm0_a3)
SELECT
    brk_name, 6, iso_a3
FROM
    ne_admin0_v3;

-- insert formal_fr as name with a rank = 7
INSERT INTO admin0_synonyms (name, rank,  adm0_a3)
SELECT
    formal_fr, 7, iso_a3
FROM
    ne_admin0_v3;

-- insert abbrv as name with a rank = 8
INSERT INTO admin0_synonyms (name, rank,  adm0_a3)
SELECT
    abbrev, 8, iso_a3
FROM
    ne_admin0_v3
WHERE
    char_length(regexp_replace(abbrev, '[^a-zA-Z\u00C0-\u00ff]+', '', 'g')) > 3;

-- insert subunit as name with a rank = 9
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    subunit, 9, iso_a3
FROM
    ne_admin0_v3;

-- insert manual additions with a rank = 10
INSERT INTO admin0_synonyms (name, rank, adm0_a3)
SELECT
    name, rank, adm0_a3
FROM
    admin0_synonym_additions
WHERE
    rank=10;

-- remove all cases where name is NULL
DELETE FROM admin0_synonyms WHERE name IS NULL;

-- remove all cases where a name is duplicated with a higher rank
DELETE FROM admin0_synonyms
    WHERE cartodb_id IN (
        SELECT
            cartodb_id
        FROM
            admin0_synonyms a
        WHERE
            0 < (
                SELECT count(*)
                FROM admin0_synonyms
                WHERE name_ = a.name_
                  AND adm0_a3 = a.adm0_a3
                  AND rank < a.rank));
