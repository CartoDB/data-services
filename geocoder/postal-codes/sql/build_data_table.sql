
---- Postal Code Polygon table ---
--- ---

-- Clear table

DELETE FROM postal_code_polygons;

-- Insert France zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'FRA', id FROM codes_postaux;

-- Insert USA zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'USA', postal_code FROM global_postal_code_polygons WHERE iso3 = 'USA';


-- Insert Canada zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'CAN', postal_code FROM global_postal_code_polygons WHERE iso3 = 'CAN';


-- Insert Australia zip codes

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'AUS', postal_code FROM global_postal_code_polygons WHERE iso3 = 'AUS';

-- Insert UK zip codes 

INSERT INTO postal_code_polygons (the_geom,adm0_a3,postal_code)
SELECT the_geom, 'GBR', postalcode FROM uk_postcodes;