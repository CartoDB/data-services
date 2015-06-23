IP address geocoder
===============

# Function

````
SELECT geocode_ip(Array['1.0.16.0', '::ffff:1.0.16.0'])
`````

# Creation steps
1. Obtain the file from http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip
2. Uncompress it and upload the `GeoLite2-City-Blocks-IPv4.csv` file
3. Rename the uploaded table as `latest_ip_address_locations`
4. Run the `sql/build_data_table` script to update the table

# Data Sources

GeoLite2 open source database [Created by MaxMind](http://www.maxmind.com) - 
http://dev.maxmind.com/geoip/geoip2/geolite2/ Download the CSV [Geolite2 City](http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip)

# Preparation details
This section doesn't require special processing.

# Testing
In order to test the data and the functions created under the script avaialble in this folder, you will need to run `bash test.sh` from `test/data` and `test/functions`.

# Historic:
* [23/06/2015]: 
  * Updates `README.md`
  * Adding test structure for IP addresses geocoder


