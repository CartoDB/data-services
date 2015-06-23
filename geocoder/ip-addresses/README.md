IP address geocoder
===============

# Function

# Creation steps

1. Upload a new dataset to the geocoder table, call it `latest_ip_address_locations`
2. Run the `sql/build_data_table` script to update the table

# Data Sources

GeoLite2 open source database [Created by MaxMind](http://www.maxmind.com) - 
http://dev.maxmind.com/geoip/geoip2/geolite2/ Download the CSV [Geolite2 City](http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip)

# Preparation details
This section doesn't require special processing.

# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Historic:
* [23/06/2015]: 
  * Updates `README.md``
  * Adding test structure for IP addresses geocoder


