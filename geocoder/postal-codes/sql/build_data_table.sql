
---- Postal Code Polygon table ---
--- ---

-- Clear table

DELETE FROM postal_code_polygons;

-- Insert France zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'FRA', id FROM codes_postaux;

-- Insert UK zip codes 

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'GBR', postalcode FROM uk_postcodes;

-- Insert Canada zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'CAN', cfsauid FROM gfsa000a11a_e;


-- Insert Australia zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'AUS', name FROM doc;


-- Insert USA zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'USA', zcta5ce10 FROM tl_2013_us_zcta510;


