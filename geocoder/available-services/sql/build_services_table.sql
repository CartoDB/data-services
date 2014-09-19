
---- available_services ---

-- Clear available admin polygons
UPDATE available_services SET admin0 = FALSE;
-- Add available services
UPDATE available_services SET admin0 = TRUE WHERE 0 < (SELECT count(*) FROM global_admin0_polygons WHERE available_services.adm0_a3 = iso3 LIMIT 1);


-- Postalcode polygons
UPDATE available_services SET postalcode_polygons = FALSE;
UPDATE available_services SET postalcode_polygons = TRUE WHERE 0 < (SELECT count(*) FROM postal_code_polygons WHERE available_services.adm0_a3 = adm0_a3 LIMIT 1);


-- Postalcode points
UPDATE available_services SET postalcode_points = FALSE;
UPDATE available_services SET postalcode_points = TRUE WHERE 0 < (SELECT count(*) FROM zipcode_points WHERE available_services.adm0_a3 = iso3 LIMIT 1);


