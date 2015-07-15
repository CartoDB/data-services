#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_functions_zipcodes_usa() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['USA'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['USA'])).postal_code_polygons" should true
    sql "SELECT ST_GeometryType((geocode_postalcode_polygons(Array['11211'], 'USA')).geom)" should ST_MultiPolygon
}

function test_geocoding_functions_zipcodes_fra() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['FRA'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['FRA'])).postal_code_polygons" should true
    sql "SELECT ST_GeometryType(((geocode_postalcode_polygons(Array['23270'], Array['FRA'])).geom))" should ST_MultiPolygon

}

function test_geocoding_functions_zipcodes_can() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['CAN'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['CAN'])).postal_code_polygons" should true
    sql "SELECT ST_GeometryType((geocode_postalcode_polygons(Array['A0J'], 'CAN')).geom)" should ST_MultiPolygon

}

function test_geocoding_functions_zipcodes_aus() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['AUS'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['AUS'])).postal_code_polygons" should true
    sql "SELECT ST_GeometryType((geocode_postalcode_polygons(Array['3012'], 'AUS')).geom)" should ST_MultiPolygon


}

#################################################### TESTS END HERE ####################################################
