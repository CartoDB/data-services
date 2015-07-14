#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_functions_ip_addr() {
    # checks that the result is false and no geometry is returned for an invalid formatted/out of range IPv4
    sql "SELECT (geocode_ip(Array['1.0.16.280.1'])).success" should false
    sql "SELECT (geocode_ip(Array['1.0.16.280.1'])).geom is null" should true

    # checks that a valid IPv4 address returns a value and a success status
    sql "SELECT (geocode_ip(Array['8.2.16.0'])).success" should true
    sql "SELECT (geocode_ip(Array['8.2.16.0'])).geom is null" should false

    # check that the returned geometry is a point
    sql "SELECT ST_GeometryType((geocode_ip(Array['8.2.16.0'])).geom)" should ST_Point

}


#################################################### TESTS END HERE ####################################################
