#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_data_ip_addr() {
    # checks the type of the IP addresses column - inet in postgres
    sql "SELECT count(*) FROM ip_address_locations where network_start_ip::inet is null" should 0
  
}


#################################################### TESTS END HERE ####################################################
