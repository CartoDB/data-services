#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_functions_zipcodes_usa() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['USA'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['USA'])).postal_code_polygons" should true

}

function test_geocoding_functions_zipcodes_fra() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['FRA'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['FRA'])).postal_code_polygons" should true
}

function test_geocoding_functions_zipcodes_can() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['CAN'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['CAN'])).postal_code_polygons" should true
}

function test_geocoding_functions_zipcodes_aus() {
    #Checks that zipcode polygons are available
    sql "SELECT (admin0_available_services(Array['AUS'])).postal_code_points" should true
    #Checks that zipcode points are available
    sql "SELECT (admin0_available_services(Array['AUS'])).postal_code_polygons" should true

}

#################################################### TESTS END HERE ####################################################
