
---- Postal Code Points table ---

-- Clear table

DELETE FROM zipcode_points;

-- Insert points

DELETE FROM zipcode_points;

INSERT INTO zip_code_points (the_geom, zipcode, iso3) 
SELECT the_geom, zipcode,
		(
		SELECT country_decoder.iso3 FROM country_decoder 
		WHERE tmp_zipcode_points.iso2 = country_decoder.iso2
		)
FROM tmp_zipcode_points
);


-- Drops temporary table

DROP TABLE tmp_zipcode_points;


