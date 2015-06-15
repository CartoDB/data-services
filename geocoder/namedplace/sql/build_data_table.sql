
---- NAMED PLACES GEOCODING ---
--- ---
--- NOTE ---
--- insert order should be from lowest populated place rank to highest  ---
--- this allows us to use table sort order instead of an explicit ORDER BY rank ---
--- in searches and reduces search cost / time --- 
--- ---
--- please, generate a backup of the current global_cities_points_limited table  --- 
--- ---

-- clear all existing data from the table --
DELETE FROM global_cities_points_limited;

-- insert data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM points_cities
    WHERE featcode = '';

-- insert data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode IS null;

-- capital of a political entity
-- insert PPLC data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLC';

-- populated place  a city, town, village, or other agglomeration of buildings where people live and work
-- insert PPL data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPL';

-- seat of a first-order administrative division  (PPLC takes precedence over PPLA)
-- insert PPLA data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLA';

-- seat of a second-order administrative division
-- insert PPLA2 data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLA2';

-- seat of a third-order administrative division
-- insert PPLA3 data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLA3';

-- seat of a fourth-order administrative division
-- insert PPLA4 data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLA4';

-- historical capital of a political entity, a former capital of a political entity
-- insert PPLCH data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLCH';

-- farm village a populated place where the population is largely engaged in agricultural activities
-- insert PPLF data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLF';

-- seat of government of a political entity
-- insert PPLG data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLG';

-- historical populated place   a populated place that no longer exists
-- insert PPLH data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLH';

-- populated locality   an area similar to a locality but with a small group of dwellings or other buildings
-- insert PPLL data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLL';

-- abandoned populated place
-- insert PPLQ data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLQ';

-- religious populated place    a populated place whose population is largely engaged in religious occupations
-- insert PPLR data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLR';

-- populated places cities, towns, villages, or other agglomerations of buildings where people live and work
-- insert PPLS data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLS';

-- destroyed populated place    a village, town or city destroyed by a natural disaster, or by war
-- insert PPLW data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLW';

-- section of populated place   
-- insert PPLX data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'PPLX';

-- israeli settlement
-- insert STLMT data from source table (allcountries) to the table
-- it assumes that the source is called "allcountries"
INSERT INTO global_cities_points_limited (the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geoname_id, gtopo30, iso2, lowername, name, population)
    SELECT the_geom, admin1, admin2, admin3, admin4, altnames, asciiname, cc2, featclass, featcode, geonameid::int, gtopo30, country, lower(name) as lowername, name, population
    FROM allcountries
    WHERE featcode = 'STLMT';

