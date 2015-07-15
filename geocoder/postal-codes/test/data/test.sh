#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_quality_zipcodes_availability() {
    #Checks count of available polygon zipcodes
    sql "SELECT count(*) FROM available_services where postal_code_polygons is true" should 4
    #Checks count of available point zipcodes
    sql "SELECT count(*) FROM available_services where postal_code_points  is true" should 65
}

function test_geocoding_quality_zipcodes_usa() {
    #Checks that zipcode polygons are available
    sql "SELECT count(*) FROM available_services where postal_code_polygons is true and adm0_a3 = 'USA'" should 1
    #Checks that zipcode points are available
    sql "SELECT count(*) FROM available_services where postal_code_points is true and adm0_a3 = 'USA'" should 1
    sql "SELECT ST_GeometryType(the_geom) from postal_code_polygons where postal_code = '11211' and adm0_a3 = 'USA'" should ST_MultiPolygon


}

function test_geocoding_quality_zipcodes_fra() {
    #Checks that zipcode polygons are available
    sql "SELECT count(*) FROM available_services where postal_code_polygons is true and adm0_a3 = 'FRA'" should 1
    #Checks that zipcode points are available
    sql "SELECT count(*) FROM available_services where postal_code_points is true and adm0_a3 = 'FRA'" should 1
    sql "SELECT ST_GeometryType(the_geom) from postal_code_polygons where postal_code = '23270' and adm0_a3 = 'FRA'" should ST_MultiPolygon
}

function test_geocoding_quality_zipcodes_can() {
    #Checks that zipcode polygons are available
    sql "SELECT count(*) FROM available_services where postal_code_polygons is true and adm0_a3 = 'CAN'" should 1
    #Checks that zipcode points are available
    sql "SELECT count(*) FROM available_services where postal_code_points is true and adm0_a3 = 'CAN'" should 1
    sql "SELECT ST_GeometryType(the_geom) from postal_code_polygons where postal_code = 'A0J' and adm0_a3 = 'CAN'" should ST_MultiPolygon

}

function test_geocoding_quality_zipcodes_aus() {
    #Checks that zipcode polygons are available
    sql "SELECT count(*) FROM available_services where postal_code_polygons is true and adm0_a3 = 'AUS'" should 1
    #Checks that zipcode points are available
    sql "SELECT count(*) FROM available_services where postal_code_points is true and adm0_a3 = 'AUS'" should 1
    sql "SELECT ST_GeometryType(the_geom) from postal_code_polygons where postal_code = '3012' and adm0_a3 = 'AUS'" should ST_MultiPolygon

}

#################################################### TESTS END HERE ####################################################
