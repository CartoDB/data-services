#!/bin/sh


#################################################### TESTS GO HERE ####################################################

function test_geocoding_functions_admin0() {
    # checks that an invalid input returns a false result and an empty geometry
    sql "SELECT (geocode_admin0_polygons(Array['Null Island'])).success" should false
    sql "SELECT (geocode_admin0_polygons(Array['Null Island'])).geom is null" should true
    sql "SELECT (admin0_synonym_lookup(Array['Null Island'])).adm0_a3 is null" should true

    # checks that all the geometries have the expected type: ST_MultiPolygon
    sql "select distinct(st_geometrytype((geocode_admin0_polygons(Array['AGO', 'REU', 'BHR', 'BHS', 'BLR', 'CHN', 'CSI', 'COL', 'KOR', 'AFG', 'ATC', 'ATG', 'AUT', 'VUT', 'SXM', 'USA', 'UZB', 'LAO', 'MAF', 'MAR', 'MOZ', 'ROU', 'SDN', 'SDS', 'SOM', 'SYR', 'URY', 'ABW', 'AUS', 'AIA', 'ALB', 'BEN', 'ARG', 'ATA', 'AZE', 'BIH', 'BJN', 'ARE', 'ALD', 'AND', 'ARM', 'ATF', 'BGR', 'PAK', 'BLM', 'BLZ', 'CUW', 'BMU', 'BOL', 'BDI', 'BEL', 'BFA', 'BGD', 'BRA', 'BRB', 'CHE', 'CHL', 'CIV', 'IDN', 'OMN', 'COG', 'HUN', 'IRQ', 'NOR', 'BRN', 'CLP', 'CMR', 'COD', 'COK', 'GIB', 'GIN', 'NPL', 'FRA', 'CNM', 'BTN', 'BWA', 'CAF', 'CAN', 'COM', 'CYM', 'CPV', 'CRI', 'CUB', 'ECU', 'ISL', 'CYN', 'EGY', 'CYP', 'CZE', 'DEU', 'ERI', 'DJI', 'TGO', 'DMA', 'DNK', 'DOM', 'DZA', 'GUM', 'GUY', 'ESB', 'ESP', 'EST', 'ETH', 'FIN', 'FJI', 'FLK', 'FRO', 'KGZ', 'GRC', 'NRU', 'FSM', 'GAB', 'GBR', 'GEO', 'KHM', 'KIR', 'NCL', 'GGY', 'GHA', 'GNQ', 'GMB', 'GNB', 'GRD', 'GRL', 'HKG', 'GTM', 'HMD', 'HND', 'HRV', 'HTI', 'IMN', 'IND', 'IOT', 'IRL', 'IRN', 'KAB', 'KAS', 'KEN', 'NIU', 'NER', 'KAZ', 'JAM', 'JEY', 'MDV', 'ISR', 'ITA', 'JOR', 'JPN', 'MEX', 'KNA', 'KOS', 'MMR', 'LCA', 'LIE', 'MAC', 'NLD', 'KWT', 'LKA', 'MLT', 'LBN', 'LBR', 'LBY', 'MCO', 'LSO', 'LTU', 'MDA', 'MDG', 'LUX', 'LVA', 'MHL', 'RUS', 'MNP', 'NZL', 'MKD', 'MLI', 'MRT', 'MNE', 'MNG', 'THA', 'MSR', 'MUS', 'MWI', 'MYS', 'NAM', 'NFK', 'NGA', 'NIC', 'PAN', 'PCN', 'PER', 'TJK', 'PGA', 'PHL', 'SLE', 'PRK', 'WSB', 'SHN', 'SLB', 'SPM', 'PLW', 'PNG', 'POL', 'PRI', 'PRT', 'PRY', 'SEN', 'PSX', 'PYF', 'QAT', 'SCR', 'STP', 'SUR', 'SVK', 'SVN', 'SWE', 'SRB', 'UKR', 'RWA', 'SER', 'VAT', 'SGP', 'SAH', 'SAU', 'SGS', 'UGA', 'SOL', 'TUR', 'WLF', 'SWZ', 'SLV', 'SMR', 'TCA', 'TCD', 'SYC', 'TKM', 'YEM', 'TLS', 'TUV', 'ZAF', 'VCT', 'VEN', 'TON', 'TTO', 'TUN', 'TWN', 'TZA', 'UMI', 'USG', 'VGB', 'VIR', 'VNM', 'WSM', 'ZMB', 'ZWE', 'CXR', 'MTQ', 'MYT', 'GLP', 'SJM', 'CCK', 'BES', 'TKL', 'ASM', 'IOA', 'BVT', 'GUF'])).geom))" should ST_MultiPolygon

    # checks that the synonym service includes the official english name of the regions
    sql "SELECT (admin0_synonym_lookup(Array['Azerbaijan'])).adm0_a3" should AZE
    sql "SELECT (admin0_synonym_lookup(Array['Georgia'])).adm0_a3" should GEO
    sql "SELECT (admin0_synonym_lookup(Array['Bahrain'])).adm0_a3" should BHR
    sql "SELECT (admin0_synonym_lookup(Array['Guinea Bissau'])).adm0_a3" should GNB
    sql "SELECT (admin0_synonym_lookup(Array['Kazakhstan'])).adm0_a3" should KAZ
    sql "SELECT (admin0_synonym_lookup(Array['Heard Island and McDonald Islands'])).adm0_a3" should HMD
    sql "SELECT (admin0_synonym_lookup(Array['Honduras'])).adm0_a3" should HND
    sql "SELECT (admin0_synonym_lookup(Array['Norway'])).adm0_a3" should NOR
    sql "SELECT (admin0_synonym_lookup(Array['Suriname'])).adm0_a3" should SUR
    sql "SELECT (admin0_synonym_lookup(Array['Chad'])).adm0_a3" should TCD
    sql "SELECT (admin0_synonym_lookup(Array['Spain'])).adm0_a3" should ESP
    sql "SELECT (admin0_synonym_lookup(Array['Brazil'])).adm0_a3" should BRA
    sql "SELECT (admin0_synonym_lookup(Array['Anguilla'])).adm0_a3" should AIA
    sql "SELECT (admin0_synonym_lookup(Array['Albania'])).adm0_a3" should ALB
    sql "SELECT (admin0_synonym_lookup(Array['Argentina'])).adm0_a3" should ARG
    sql "SELECT (admin0_synonym_lookup(Array['Aruba'])).adm0_a3" should ABW
    sql "SELECT (admin0_synonym_lookup(Array['Afghanistan'])).adm0_a3" should AFG
    sql "SELECT (admin0_synonym_lookup(Array['Angola'])).adm0_a3" should AGO
    sql "SELECT (admin0_synonym_lookup(Array['Cameroon'])).adm0_a3" should CMR
    sql "SELECT (admin0_synonym_lookup(Array['Somalia'])).adm0_a3" should SOM
    sql "SELECT (admin0_synonym_lookup(Array['Democratic Republic of the Congo'])).adm0_a3" should COD
    sql "SELECT (admin0_synonym_lookup(Array['Republic of Congo'])).adm0_a3" should COG
    sql "SELECT (admin0_synonym_lookup(Array['United Arab Emirates'])).adm0_a3" should ARE
    sql "SELECT (admin0_synonym_lookup(Array['Estonia'])).adm0_a3" should EST
    sql "SELECT (admin0_synonym_lookup(Array['American Samoa'])).adm0_a3" should ASM
    sql "SELECT (admin0_synonym_lookup(Array['Antarctica'])).adm0_a3" should ATA
    sql "SELECT (admin0_synonym_lookup(Array['Ashmore and Cartier Islands'])).adm0_a3" should ATC
    sql "SELECT (admin0_synonym_lookup(Array['Saint Barthelemy'])).adm0_a3" should BLM
    sql "SELECT (admin0_synonym_lookup(Array['Bajo Nuevo Bank (Petrel Is.)'])).adm0_a3" should BJN
    sql "SELECT (admin0_synonym_lookup(Array['Belarus'])).adm0_a3" should BLR
    sql "SELECT (admin0_synonym_lookup(Array['Belize'])).adm0_a3" should BLZ
    sql "SELECT (admin0_synonym_lookup(Array['Antigua and Barbuda'])).adm0_a3" should ATG
    sql "SELECT (admin0_synonym_lookup(Array['Australia'])).adm0_a3" should AUS
    sql "SELECT (admin0_synonym_lookup(Array['Austria'])).adm0_a3" should AUT
    sql "SELECT (admin0_synonym_lookup(Array['The Bahamas'])).adm0_a3" should BHS
    sql "SELECT (admin0_synonym_lookup(Array['Bosnia and Herzegovina'])).adm0_a3" should BIH
    sql "SELECT (admin0_synonym_lookup(Array['Ivory Coast'])).adm0_a3" should CIV
    sql "SELECT (admin0_synonym_lookup(Array['Aland'])).adm0_a3" should ALD
    sql "SELECT (admin0_synonym_lookup(Array['Andorra'])).adm0_a3" should AND
    sql "SELECT (admin0_synonym_lookup(Array['Armenia'])).adm0_a3" should ARM
    sql "SELECT (admin0_synonym_lookup(Array['French Southern and Antarctic Lands'])).adm0_a3" should ATF
    sql "SELECT (admin0_synonym_lookup(Array['Bulgaria'])).adm0_a3" should BGR
    sql "SELECT (admin0_synonym_lookup(Array['Ecuador'])).adm0_a3" should ECU
    sql "SELECT (admin0_synonym_lookup(Array['Bermuda'])).adm0_a3" should BMU
    sql "SELECT (admin0_synonym_lookup(Array['Bolivia'])).adm0_a3" should BOL
    sql "SELECT (admin0_synonym_lookup(Array['Barbados'])).adm0_a3" should BRB
    sql "SELECT (admin0_synonym_lookup(Array['Switzerland'])).adm0_a3" should CHE
    sql "SELECT (admin0_synonym_lookup(Array['Chile'])).adm0_a3" should CHL
    sql "SELECT (admin0_synonym_lookup(Array['China'])).adm0_a3" should CHN
    sql "SELECT (admin0_synonym_lookup(Array['Burundi'])).adm0_a3" should BDI
    sql "SELECT (admin0_synonym_lookup(Array['Belgium'])).adm0_a3" should BEL
    sql "SELECT (admin0_synonym_lookup(Array['Benin'])).adm0_a3" should BEN
    sql "SELECT (admin0_synonym_lookup(Array['Burkina Faso'])).adm0_a3" should BFA
    sql "SELECT (admin0_synonym_lookup(Array['Bangladesh'])).adm0_a3" should BGD
    sql "SELECT (admin0_synonym_lookup(Array['Brunei'])).adm0_a3" should BRN
    sql "SELECT (admin0_synonym_lookup(Array['Clipperton Island'])).adm0_a3" should CLP
    sql "SELECT (admin0_synonym_lookup(Array['Ethiopia'])).adm0_a3" should ETH
    sql "SELECT (admin0_synonym_lookup(Array['Finland'])).adm0_a3" should FIN
    sql "SELECT (admin0_synonym_lookup(Array['Cook Islands'])).adm0_a3" should COK
    sql "SELECT (admin0_synonym_lookup(Array['Colombia'])).adm0_a3" should COL
    sql "SELECT (admin0_synonym_lookup(Array['Curaçao'])).adm0_a3" should CUW
    sql "SELECT (admin0_synonym_lookup(Array['Cyprus No Mans Area'])).adm0_a3" should CNM
    sql "SELECT (admin0_synonym_lookup(Array['Comoros'])).adm0_a3" should COM
    sql "SELECT (admin0_synonym_lookup(Array['Croatia'])).adm0_a3" should HRV
    sql "SELECT (admin0_synonym_lookup(Array['Falkland Islands'])).adm0_a3" should FLK
    sql "SELECT (admin0_synonym_lookup(Array['France'])).adm0_a3" should FRA
    sql "SELECT (admin0_synonym_lookup(Array['Gibraltar'])).adm0_a3" should GIB
    sql "SELECT (admin0_synonym_lookup(Array['Fiji'])).adm0_a3" should FJI
    sql "SELECT (admin0_synonym_lookup(Array['Bhutan'])).adm0_a3" should BTN
    sql "SELECT (admin0_synonym_lookup(Array['Botswana'])).adm0_a3" should BWA
    sql "SELECT (admin0_synonym_lookup(Array['Central African Republic'])).adm0_a3" should CAF
    sql "SELECT (admin0_synonym_lookup(Array['Canada'])).adm0_a3" should CAN
    sql "SELECT (admin0_synonym_lookup(Array['Cape Verde'])).adm0_a3" should CPV
    sql "SELECT (admin0_synonym_lookup(Array['Costa Rica'])).adm0_a3" should CRI
    sql "SELECT (admin0_synonym_lookup(Array['Coral Sea Islands'])).adm0_a3" should CSI
    sql "SELECT (admin0_synonym_lookup(Array['Cuba'])).adm0_a3" should CUB
    sql "SELECT (admin0_synonym_lookup(Array['Cayman Islands'])).adm0_a3" should CYM
    sql "SELECT (admin0_synonym_lookup(Array['Dhekelia Sovereign Base Area'])).adm0_a3" should ESB
    sql "SELECT (admin0_synonym_lookup(Array['Northern Cyprus'])).adm0_a3" should CYN
    sql "SELECT (admin0_synonym_lookup(Array['Egypt'])).adm0_a3" should EGY
    sql "SELECT (admin0_synonym_lookup(Array['Guinea'])).adm0_a3" should GIN
    sql "SELECT (admin0_synonym_lookup(Array['Haiti'])).adm0_a3" should HTI
    sql "SELECT (admin0_synonym_lookup(Array['Cyprus'])).adm0_a3" should CYP
    sql "SELECT (admin0_synonym_lookup(Array['Czech Republic'])).adm0_a3" should CZE
    sql "SELECT (admin0_synonym_lookup(Array['Niger'])).adm0_a3" should NER
    sql "SELECT (admin0_synonym_lookup(Array['Germany'])).adm0_a3" should DEU
    sql "SELECT (admin0_synonym_lookup(Array['Eritrea'])).adm0_a3" should ERI
    sql "SELECT (admin0_synonym_lookup(Array['Hungary'])).adm0_a3" should HUN
    sql "SELECT (admin0_synonym_lookup(Array['Dominica'])).adm0_a3" should DMA
    sql "SELECT (admin0_synonym_lookup(Array['Denmark'])).adm0_a3" should DNK
    sql "SELECT (admin0_synonym_lookup(Array['Dominican Republic'])).adm0_a3" should DOM
    sql "SELECT (admin0_synonym_lookup(Array['Algeria'])).adm0_a3" should DZA
    sql "SELECT (admin0_synonym_lookup(Array['Indonesia'])).adm0_a3" should IDN
    sql "SELECT (admin0_synonym_lookup(Array['Djibouti'])).adm0_a3" should DJI
    sql "SELECT (admin0_synonym_lookup(Array['Ghana'])).adm0_a3" should GHA
    sql "SELECT (admin0_synonym_lookup(Array['Federated States of Micronesia'])).adm0_a3" should FSM
    sql "SELECT (admin0_synonym_lookup(Array['Gabon'])).adm0_a3" should GAB
    sql "SELECT (admin0_synonym_lookup(Array['United Kingdom'])).adm0_a3" should GBR
    sql "SELECT (admin0_synonym_lookup(Array['Guernsey'])).adm0_a3" should GGY
    sql "SELECT (admin0_synonym_lookup(Array['Faroe Islands'])).adm0_a3" should FRO
    sql "SELECT (admin0_synonym_lookup(Array['Guam'])).adm0_a3" should GUM
    sql "SELECT (admin0_synonym_lookup(Array['Guyana'])).adm0_a3" should GUY
    sql "SELECT (admin0_synonym_lookup(Array['Equatorial Guinea'])).adm0_a3" should GNQ
    sql "SELECT (admin0_synonym_lookup(Array['Greece'])).adm0_a3" should GRC
    sql "SELECT (admin0_synonym_lookup(Array['Siachen Glacier'])).adm0_a3" should KAS
    sql "SELECT (admin0_synonym_lookup(Array['Grenada'])).adm0_a3" should GRD
    sql "SELECT (admin0_synonym_lookup(Array['Greenland'])).adm0_a3" should GRL
    sql "SELECT (admin0_synonym_lookup(Array['Hong Kong S.A.R.'])).adm0_a3" should HKG
    sql "SELECT (admin0_synonym_lookup(Array['Gambia'])).adm0_a3" should GMB
    sql "SELECT (admin0_synonym_lookup(Array['Kenya'])).adm0_a3" should KEN
    sql "SELECT (admin0_synonym_lookup(Array['Guatemala'])).adm0_a3" should GTM
    sql "SELECT (admin0_synonym_lookup(Array['Isle of Man'])).adm0_a3" should IMN
    sql "SELECT (admin0_synonym_lookup(Array['India'])).adm0_a3" should IND
    sql "SELECT (admin0_synonym_lookup(Array['Kyrgyzstan'])).adm0_a3" should KGZ
    sql "SELECT (admin0_synonym_lookup(Array['Cambodia'])).adm0_a3" should KHM
    sql "SELECT (admin0_synonym_lookup(Array['Indian Ocean Territories'])).adm0_a3" should IOA
    sql "SELECT (admin0_synonym_lookup(Array['Nigeria'])).adm0_a3" should NGA
    sql "SELECT (admin0_synonym_lookup(Array['British Indian Ocean Territory'])).adm0_a3" should IOT
    sql "SELECT (admin0_synonym_lookup(Array['Ireland'])).adm0_a3" should IRL
    sql "SELECT (admin0_synonym_lookup(Array['Iran'])).adm0_a3" should IRN
    sql "SELECT (admin0_synonym_lookup(Array['Iraq'])).adm0_a3" should IRQ
    sql "SELECT (admin0_synonym_lookup(Array['Iceland'])).adm0_a3" should ISL
    sql "SELECT (admin0_synonym_lookup(Array['Liechtenstein'])).adm0_a3" should LIE
    sql "SELECT (admin0_synonym_lookup(Array['Baykonur Cosmodrome'])).adm0_a3" should KAB
    sql "SELECT (admin0_synonym_lookup(Array['Kiribati'])).adm0_a3" should KIR
    sql "SELECT (admin0_synonym_lookup(Array['Saint Kitts and Nevis'])).adm0_a3" should KNA
    sql "SELECT (admin0_synonym_lookup(Array['South Korea'])).adm0_a3" should KOR
    sql "SELECT (admin0_synonym_lookup(Array['Morocco'])).adm0_a3" should MAR
    sql "SELECT (admin0_synonym_lookup(Array['Niue'])).adm0_a3" should NIU
    sql "SELECT (admin0_synonym_lookup(Array['Jamaica'])).adm0_a3" should JAM
    sql "SELECT (admin0_synonym_lookup(Array['Jersey'])).adm0_a3" should JEY
    sql "SELECT (admin0_synonym_lookup(Array['Maldives'])).adm0_a3" should MDV
    sql "SELECT (admin0_synonym_lookup(Array['Israel'])).adm0_a3" should ISR
    sql "SELECT (admin0_synonym_lookup(Array['Italy'])).adm0_a3" should ITA
    sql "SELECT (admin0_synonym_lookup(Array['Jordan'])).adm0_a3" should JOR
    sql "SELECT (admin0_synonym_lookup(Array['Japan'])).adm0_a3" should JPN
    sql "SELECT (admin0_synonym_lookup(Array['Mexico'])).adm0_a3" should MEX
    sql "SELECT (admin0_synonym_lookup(Array['Kosovo'])).adm0_a3" should KOS
    sql "SELECT (admin0_synonym_lookup(Array['Saint Lucia'])).adm0_a3" should LCA
    sql "SELECT (admin0_synonym_lookup(Array['Namibia'])).adm0_a3" should NAM
    sql "SELECT (admin0_synonym_lookup(Array['Kuwait'])).adm0_a3" should KWT
    sql "SELECT (admin0_synonym_lookup(Array['Laos'])).adm0_a3" should LAO
    sql "SELECT (admin0_synonym_lookup(Array['Sri Lanka'])).adm0_a3" should LKA
    sql "SELECT (admin0_synonym_lookup(Array['Norfolk Island'])).adm0_a3" should NFK
    sql "SELECT (admin0_synonym_lookup(Array['Malta'])).adm0_a3" should MLT
    sql "SELECT (admin0_synonym_lookup(Array['Myanmar'])).adm0_a3" should MMR
    sql "SELECT (admin0_synonym_lookup(Array['Macao S.A.R'])).adm0_a3" should MAC
    sql "SELECT (admin0_synonym_lookup(Array['Saint Martin'])).adm0_a3" should MAF
    sql "SELECT (admin0_synonym_lookup(Array['Luxembourg'])).adm0_a3" should LUX
    sql "SELECT (admin0_synonym_lookup(Array['Latvia'])).adm0_a3" should LVA
    sql "SELECT (admin0_synonym_lookup(Array['Lebanon'])).adm0_a3" should LBN
    sql "SELECT (admin0_synonym_lookup(Array['Liberia'])).adm0_a3" should LBR
    sql "SELECT (admin0_synonym_lookup(Array['Libya'])).adm0_a3" should LBY
    sql "SELECT (admin0_synonym_lookup(Array['Monaco'])).adm0_a3" should MCO
    sql "SELECT (admin0_synonym_lookup(Array['Lesotho'])).adm0_a3" should LSO
    sql "SELECT (admin0_synonym_lookup(Array['Lithuania'])).adm0_a3" should LTU
    sql "SELECT (admin0_synonym_lookup(Array['Moldova'])).adm0_a3" should MDA
    sql "SELECT (admin0_synonym_lookup(Array['Madagascar'])).adm0_a3" should MDG
    sql "SELECT (admin0_synonym_lookup(Array['Marshall Islands'])).adm0_a3" should MHL
    sql "SELECT (admin0_synonym_lookup(Array['New Caledonia'])).adm0_a3" should NCL
    sql "SELECT (admin0_synonym_lookup(Array['Nicaragua'])).adm0_a3" should NIC
    sql "SELECT (admin0_synonym_lookup(Array['Netherlands'])).adm0_a3" should NLD
    sql "SELECT (admin0_synonym_lookup(Array['Mauritius'])).adm0_a3" should MUS
    sql "SELECT (admin0_synonym_lookup(Array['Malawi'])).adm0_a3" should MWI
    sql "SELECT (admin0_synonym_lookup(Array['Malaysia'])).adm0_a3" should MYS
    sql "SELECT (admin0_synonym_lookup(Array['Ukraine'])).adm0_a3" should UKR
    sql "SELECT (admin0_synonym_lookup(Array['Northern Mariana Islands'])).adm0_a3" should MNP
    sql "SELECT (admin0_synonym_lookup(Array['Mozambique'])).adm0_a3" should MOZ
    sql "SELECT (admin0_synonym_lookup(Array['Macedonia'])).adm0_a3" should MKD
    sql "SELECT (admin0_synonym_lookup(Array['Mali'])).adm0_a3" should MLI
    sql "SELECT (admin0_synonym_lookup(Array['Mauritania'])).adm0_a3" should MRT
    sql "SELECT (admin0_synonym_lookup(Array['Montenegro'])).adm0_a3" should MNE
    sql "SELECT (admin0_synonym_lookup(Array['Mongolia'])).adm0_a3" should MNG
    sql "SELECT (admin0_synonym_lookup(Array['Peru'])).adm0_a3" should PER
    sql "SELECT (admin0_synonym_lookup(Array['Montserrat'])).adm0_a3" should MSR
    sql "SELECT (admin0_synonym_lookup(Array['Nepal'])).adm0_a3" should NPL
    sql "SELECT (admin0_synonym_lookup(Array['Nauru'])).adm0_a3" should NRU
    sql "SELECT (admin0_synonym_lookup(Array['New Zealand'])).adm0_a3" should NZL
    sql "SELECT (admin0_synonym_lookup(Array['Oman'])).adm0_a3" should OMN
    sql "SELECT (admin0_synonym_lookup(Array['Pakistan'])).adm0_a3" should PAK
    sql "SELECT (admin0_synonym_lookup(Array['Panama'])).adm0_a3" should PAN
    sql "SELECT (admin0_synonym_lookup(Array['Pitcairn Islands'])).adm0_a3" should PCN
    sql "SELECT (admin0_synonym_lookup(Array['Spratly Islands'])).adm0_a3" should PGA
    sql "SELECT (admin0_synonym_lookup(Array['Philippines'])).adm0_a3" should PHL
    sql "SELECT (admin0_synonym_lookup(Array['Romania'])).adm0_a3" should ROU
    sql "SELECT (admin0_synonym_lookup(Array['Sierra Leone'])).adm0_a3" should SLE
    sql "SELECT (admin0_synonym_lookup(Array['Slovenia'])).adm0_a3" should SVN
    sql "SELECT (admin0_synonym_lookup(Array['Sweden'])).adm0_a3" should SWE
    sql "SELECT (admin0_synonym_lookup(Array['Russia'])).adm0_a3" should RUS
    sql "SELECT (admin0_synonym_lookup(Array['Saint Pierre and Miquelon'])).adm0_a3" should SPM
    sql "SELECT (admin0_synonym_lookup(Array['Republic of Serbia'])).adm0_a3" should SRB
    sql "SELECT (admin0_synonym_lookup(Array['Saint Helena'])).adm0_a3" should SHN
    sql "SELECT (admin0_synonym_lookup(Array['Palau'])).adm0_a3" should PLW
    sql "SELECT (admin0_synonym_lookup(Array['Papua New Guinea'])).adm0_a3" should PNG
    sql "SELECT (admin0_synonym_lookup(Array['Poland'])).adm0_a3" should POL
    sql "SELECT (admin0_synonym_lookup(Array['Solomon Islands'])).adm0_a3" should SLB
    sql "SELECT (admin0_synonym_lookup(Array['Puerto Rico'])).adm0_a3" should PRI
    sql "SELECT (admin0_synonym_lookup(Array['North Korea'])).adm0_a3" should PRK
    sql "SELECT (admin0_synonym_lookup(Array['Portugal'])).adm0_a3" should PRT
    sql "SELECT (admin0_synonym_lookup(Array['Paraguay'])).adm0_a3" should PRY
    sql "SELECT (admin0_synonym_lookup(Array['Senegal'])).adm0_a3" should SEN
    sql "SELECT (admin0_synonym_lookup(Array['Palestine'])).adm0_a3" should PSX
    sql "SELECT (admin0_synonym_lookup(Array['French Polynesia'])).adm0_a3" should PYF
    sql "SELECT (admin0_synonym_lookup(Array['Qatar'])).adm0_a3" should QAT
    sql "SELECT (admin0_synonym_lookup(Array['Rwanda'])).adm0_a3" should RWA
    sql "SELECT (admin0_synonym_lookup(Array['Serranilla Bank'])).adm0_a3" should SER
    sql "SELECT (admin0_synonym_lookup(Array['Scarborough Reef'])).adm0_a3" should SCR
    sql "SELECT (admin0_synonym_lookup(Array['Singapore'])).adm0_a3" should SGP
    sql "SELECT (admin0_synonym_lookup(Array['Western Sahara'])).adm0_a3" should SAH
    sql "SELECT (admin0_synonym_lookup(Array['Saudi Arabia'])).adm0_a3" should SAU
    sql "SELECT (admin0_synonym_lookup(Array['Sudan'])).adm0_a3" should SDN
    sql "SELECT (admin0_synonym_lookup(Array['South Sudan'])).adm0_a3" should SDS
    sql "SELECT (admin0_synonym_lookup(Array['Akrotiri Sovereign Base Area'])).adm0_a3" should WSB
    sql "SELECT (admin0_synonym_lookup(Array['Sao Tome and Principe'])).adm0_a3" should STP
    sql "SELECT (admin0_synonym_lookup(Array['South Georgia and South Sandwich Islands'])).adm0_a3" should SGS
    sql "SELECT (admin0_synonym_lookup(Array['Uganda'])).adm0_a3" should UGA
    sql "SELECT (admin0_synonym_lookup(Array['Swaziland'])).adm0_a3" should SWZ
    sql "SELECT (admin0_synonym_lookup(Array['Sint Maarten'])).adm0_a3" should SXM
    sql "SELECT (admin0_synonym_lookup(Array['Thailand'])).adm0_a3" should THA
    sql "SELECT (admin0_synonym_lookup(Array['Turkmenistan'])).adm0_a3" should TKM
    sql "SELECT (admin0_synonym_lookup(Array['Wallis and Futuna'])).adm0_a3" should WLF
    sql "SELECT (admin0_synonym_lookup(Array['El Salvador'])).adm0_a3" should SLV
    sql "SELECT (admin0_synonym_lookup(Array['San Marino'])).adm0_a3" should SMR
    sql "SELECT (admin0_synonym_lookup(Array['Somaliland'])).adm0_a3" should SOL
    sql "SELECT (admin0_synonym_lookup(Array['Turkey'])).adm0_a3" should TUR
    sql "SELECT (admin0_synonym_lookup(Array['Vanuatu'])).adm0_a3" should VUT
    sql "SELECT (admin0_synonym_lookup(Array['Slovakia'])).adm0_a3" should SVK
    sql "SELECT (admin0_synonym_lookup(Array['Turks and Caicos Islands'])).adm0_a3" should TCA
    sql "SELECT (admin0_synonym_lookup(Array['Togo'])).adm0_a3" should TGO
    sql "SELECT (admin0_synonym_lookup(Array['Seychelles'])).adm0_a3" should SYC
    sql "SELECT (admin0_synonym_lookup(Array['Syria'])).adm0_a3" should SYR
    sql "SELECT (admin0_synonym_lookup(Array['Tajikistan'])).adm0_a3" should TJK
    sql "SELECT (admin0_synonym_lookup(Array['East Timor'])).adm0_a3" should TLS
    sql "SELECT (admin0_synonym_lookup(Array['Vatican'])).adm0_a3" should VAT
    sql "SELECT (admin0_synonym_lookup(Array['Uruguay'])).adm0_a3" should URY
    sql "SELECT (admin0_synonym_lookup(Array['United States of America'])).adm0_a3" should USA
    sql "SELECT (admin0_synonym_lookup(Array['Tuvalu'])).adm0_a3" should TUV
    sql "SELECT (admin0_synonym_lookup(Array['US Naval Base Guantanamo Bay'])).adm0_a3" should USG
    sql "SELECT (admin0_synonym_lookup(Array['Uzbekistan'])).adm0_a3" should UZB
    sql "SELECT (admin0_synonym_lookup(Array['Tonga'])).adm0_a3" should TON
    sql "SELECT (admin0_synonym_lookup(Array['United States Minor Outlying Islands'])).adm0_a3" should UMI
    sql "SELECT (admin0_synonym_lookup(Array['Trinidad and Tobago'])).adm0_a3" should TTO
    sql "SELECT (admin0_synonym_lookup(Array['Tunisia'])).adm0_a3" should TUN
    sql "SELECT (admin0_synonym_lookup(Array['Taiwan'])).adm0_a3" should TWN
    sql "SELECT (admin0_synonym_lookup(Array['United Republic of Tanzania'])).adm0_a3" should TZA
    sql "SELECT (admin0_synonym_lookup(Array['Saint Vincent and the Grenadines'])).adm0_a3" should VCT
    sql "SELECT (admin0_synonym_lookup(Array['Venezuela'])).adm0_a3" should VEN
    sql "SELECT (admin0_synonym_lookup(Array['British Virgin Islands'])).adm0_a3" should VGB
    sql "SELECT (admin0_synonym_lookup(Array['United States Virgin Islands'])).adm0_a3" should VIR
    sql "SELECT (admin0_synonym_lookup(Array['Vietnam'])).adm0_a3" should VNM
    sql "SELECT (admin0_synonym_lookup(Array['Samoa'])).adm0_a3" should WSM
    sql "SELECT (admin0_synonym_lookup(Array['Yemen'])).adm0_a3" should YEM
    sql "SELECT (admin0_synonym_lookup(Array['South Africa'])).adm0_a3" should ZAF
    sql "SELECT (admin0_synonym_lookup(Array['Zambia'])).adm0_a3" should ZMB
    sql "SELECT (admin0_synonym_lookup(Array['Zimbabwe'])).adm0_a3" should ZWE

    # checks that the centroid of the result obtained intersects with the desirable bounding box
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-70.0624080069999 12.417669989,-70.0624080069999 12.6321475280001,-69.8768204419999 12.6321475280001,-69.8768204419999 12.417669989,-70.0624080069999 12.417669989))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ABW'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((60.4867777910001 29.3866053260001,60.4867777910001 38.4736734020001,74.8923067630001 38.4736734020001,74.8923067630001 29.3866053260001,60.4867777910001 29.3866053260001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AFG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((11.6693941430001 -18.0314047239998,11.6693941430001 -4.39120371499996,24.0617143150001 -4.39120371499996,24.0617143150001 -18.0314047239998,11.6693941430001 -18.0314047239998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AGO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-63.4288223949999 18.1690941430001,-63.4288223949999 18.6012637390001,-62.9726456369999 18.6012637390001,-62.9726456369999 18.1690941430001,-63.4288223949999 18.1690941430001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AIA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((19.2720325110001 39.637013245,19.2720325110001 42.6548135380001,21.0366793210001 42.6548135380001,21.0366793210001 39.637013245,19.2720325110001 39.637013245))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ALB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((19.5131942070001 59.9044863950001,19.5131942070001 60.4807803410001,21.0966903000001 60.4807803410001,21.0966903000001 59.9044863950001,19.5131942070001 59.9044863950001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ALD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((1.4064563390001 42.4286774700001,1.4064563390001 42.649361674,1.76509078000015 42.649361674,1.76509078000015 42.4286774700001,1.4064563390001 42.4286774700001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AND'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((51.5693465500001 22.6209459430001,51.5693465500001 26.0747919720001,56.3836369150001 26.0747919720001,56.3836369150001 22.6209459430001,51.5693465500001 22.6209459430001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ARE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-73.5880358489999 -55.0520158829998,-73.5880358489999 -21.7869377639999,-53.6615518799999 -21.7869377639999,-53.6615518799999 -55.0520158829998,-73.5880358489999 -55.0520158829998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ARG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((43.4362939860001 38.8637012740001,43.4362939860001 41.2904523730001,46.6026123460001 41.2904523730001,46.6026123460001 38.8637012740001,43.4362939860001 38.8637012740001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ARM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-170.831247525 -14.5328915339999,-170.831247525 -14.1688778629998,-168.160471158 -14.1688778629998,-168.160471158 -14.5328915339999,-170.831247525 -14.5328915339999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ASM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-180 -90,-180 -60.516208592,180 -60.516208592,180 -90,-180 -90))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ATA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((123.575043165 -12.4385718729998,123.575043165 -12.4266089819999,123.597748243 -12.4266089819999,123.597748243 -12.4385718729998,123.575043165 -12.4385718729998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ATC'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((39.7282820970001 -49.7216122379999,39.7282820970001 -11.5506324199998,77.5852156910001 -11.5506324199998,77.5852156910001 -49.7216122379999,39.7282820970001 -49.7216122379999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ATF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.8941544259999 16.9892438820001,-61.8941544259999 17.7276878930001,-61.6675919259999 17.7276878930001,-61.6675919259999 16.9892438820001,-61.8941544259999 16.9892438820001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ATG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((112.919444207 -54.750420831,112.919444207 -9.24016692499987,159.106455925 -9.24016692499987,159.106455925 -54.750420831,112.919444207 -54.750420831))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AUS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((9.52115482500011 46.3786430870001,9.52115482500011 49.0097744750001,17.1483378500001 49.0097744750001,17.1483378500001 46.3786430870001,9.52115482500011 46.3786430870001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AUT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((44.7745585530002 38.392644755,44.7745585530002 41.8904415900002,50.6257430350001 41.8904415900002,50.6257430350001 38.392644755,44.7745585530002 38.392644755))', 4326), ST_Centroid((geocode_admin0_polygons(Array['AZE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((28.9868917230001 -4.46334401499993,28.9868917230001 -2.30306243899987,30.8339624430001 -2.30306243899987,30.8339624430001 -4.46334401499993,28.9868917230001 -4.46334401499993))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BDI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((2.52179992769047 49.495222881,2.52179992769047 51.4962376910001,6.37452518700007 51.4962376910001,6.37452518700007 49.495222881,2.52179992769047 49.495222881))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BEL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((0.759880818000113 6.21389923179639,0.759880818000113 12.3992442830001,3.83741906700001 12.3992442830001,3.83741906700001 6.21389923179639,0.759880818000113 6.21389923179639))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BEN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-68.4173884759999 12.0220401060001,-68.4173884759999 12.3102074240002,-68.1900121739999 12.3102074240002,-68.1900121739999 12.0220401060001,-68.4173884759999 12.0220401060001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BES'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-5.52257808499988 9.39188262900012,-5.52257808499988 15.0799075320001,2.39016890400009 15.0799075320001,2.39016890400009 9.39188262900012,-5.52257808499988 9.39188262900012))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BFA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((88.0217895920001 20.738714911,88.0217895920001 26.6235440070001,92.6428511970002 26.6235440070001,92.6428511970002 20.738714911,88.0217895920001 20.738714911))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BGD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((22.3450232340001 41.2381041470001,22.3450232340001 44.228434539,28.6035262380001 44.228434539,28.6035262380001 41.2381041470001,22.3450232340001 41.2381041470001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BGR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((50.448903842 25.7895368510001,50.448903842 26.242580471,50.6456598131816 26.242580471,50.6456598131816 25.7895368510001,50.448903842 25.7895368510001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BHR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-79.5943497389999 20.9123989090001,-79.5943497389999 26.9284121770001,-72.7461645169999 26.9284121770001,-72.7461645169999 20.9123989090001,-79.5943497389999 20.9123989090001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BHS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((15.7160738520001 42.5592121380002,15.7160738520001 45.2845238250002,19.618884725 45.2845238250002,19.618884725 42.5592121380002,15.7160738520001 42.5592121380002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BIH'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-79.9892878899999 15.7941755230001,-79.9892878899999 15.7962100280001,-79.9863988919999 15.7962100280001,-79.9863988919999 15.7941755230001,-79.9892878899999 15.7941755230001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BJN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-62.8673396479999 17.8819847680001,-62.8673396479999 17.9291445980001,-62.7916560539999 17.9291445980001,-62.7916560539999 17.8819847680001,-62.8673396479999 17.8819847680001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BLM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((23.165644979 51.2351683560001,23.165644979 56.1568059290001,32.7195321040001 56.1568059290001,32.7195321040001 51.2351683560001,23.165644979 51.2351683560001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BLR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-89.2365122079999 15.8796519990001,-89.2365122079999 18.4907587690001,-87.7830704419999 18.4907587690001,-87.7830704419999 15.8796519990001,-89.2365122079999 15.8796519990001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BLZ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-64.8859939889704 32.2480773815958,-64.8859939889704 32.3886579450001,-64.6476307056406 32.3886579450001,-64.6476307056406 32.2480773815958,-64.8859939889704 32.2480773815958))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BMU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-69.6664922699999 -22.8972575879999,-69.6664922699999 -9.67982147199997,-57.4656607669999 -9.67982147199997,-57.4656607669999 -22.8972575879999,-69.6664922699999 -22.8972575879999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BOL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-74.018474691 -33.742280375,-74.018474691 5.26722483300009,-28.8770645819999 5.26722483300009,-28.8770645819999 -33.742280375,-74.018474691 -33.742280375))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BRA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-59.6542048819999 13.051174221,-59.6542048819999 13.344549872,-59.4269099599999 13.344549872,-59.4269099599999 13.051174221,-59.6542048819999 13.051174221))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BRB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((113.99878991 4.01668101000011,113.99878991 5.05719635600018,115.360741008 5.05719635600018,115.360741008 4.01668101000011,113.99878991 4.01668101000011))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BRN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((88.7300667720001 26.6961493940002,88.7300667720001 28.3583989307863,92.0887764890001 28.3583989307863,92.0887764890001 26.6961493940002,88.7300667720001 26.6961493940002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BTN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((3.34555097700007 -54.4624976539999,3.34555097700007 -54.3801408829999,3.48666425900012 -54.3801408829999,3.48666425900012 -54.4624976539999,3.34555097700007 -54.4624976539999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BVT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((19.9783459880001 -26.891794128,19.9783459880001 -17.7818075559999,29.3500736890001 -17.7818075559999,29.3500736890001 -26.891794128,19.9783459880001 -26.891794128))', 4326), ST_Centroid((geocode_admin0_polygons(Array['BWA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((14.3872660720001 2.23645375600006,14.3872660720001 11.0008283490001,27.4413013100001 11.0008283490001,27.4413013100001 2.23645375600006,14.3872660720001 2.23645375600006))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CAF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-141.005548637109 41.6690855920001,-141.005548637109 83.1165225280001,-52.616607226 83.1165225280001,-52.616607226 41.6690855920001,-141.005548637109 41.6690855920001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CAN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((96.821543816 -12.1999651019998,96.821543816 -12.1265601539999,96.9210718110001 -12.1265601539999,96.9210718110001 -12.1999651019998,96.821543816 -12.1999651019998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CCK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((5.95480920400013 45.820718486,5.95480920400013 47.8011660770001,10.466626831 47.8011660770001,10.466626831 45.820718486,5.95480920400013 45.820718486))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CHE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-109.453724739 -55.9185042229998,-109.453724739 -17.506588198,-66.4208064439999 -17.506588198,-66.4208064439999 -55.9185042229998,-109.453724739 -55.9185042229998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CHL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((73.6022563070002 15.775376695,73.6022563070002 53.569444479,134.772579387 53.569444479,134.772579387 15.775376695,73.6022563070002 15.775376695))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CHN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-8.61871984899992 4.34406159100013,-8.61871984899992 10.7264781700001,-2.50632808399993 10.7264781700001,-2.50632808399993 4.34406159100013,-8.61871984899992 4.34406159100013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CIV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-109.234242317 10.2815615910001,-109.234242317 10.3110212260001,-109.210357226 10.3110212260001,-109.210357226 10.2815615910001,-109.234242317 10.2815615910001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CLP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((8.50505618600005 1.65455129000014,8.50505618600005 13.081140646,16.2077234290001 13.081140646,16.2077234290001 1.65455129000014,8.50505618600005 1.65455129000014))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CMR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.5848087900001 34.9777627570001,32.5848087900001 35.1994029740002,34.0219607300423 35.1994029740002,34.0219607300423 34.9777627570001,32.5848087900001 34.9777627570001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CNM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((12.2105548693531 -13.4583505239999,12.2105548693531 5.37528025300014,31.2804468180001 5.37528025300014,31.2804468180001 -13.4583505239999,12.2105548693531 -13.4583505239999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['COD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((11.1140163040629 -5.01963083599986,11.1140163040629 3.70827606200005,18.64240686 3.70827606200005,18.64240686 -5.01963083599986,11.1140163040629 -5.01963083599986))', 4326), ST_Centroid((geocode_admin0_polygons(Array['COG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-165.824533658 -21.9388973939999,-165.824533658 -8.94670989399988,-157.312814908 -8.94670989399988,-157.312814908 -21.9388973939999,-165.824533658 -21.9388973939999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['COK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-81.72370358 -4.23648447699985,-81.72370358 13.5783552100001,-66.8750605879999 13.5783552100001,-66.8750605879999 -4.23648447699985,-81.72370358 -4.23648447699985))', 4326), ST_Centroid((geocode_admin0_polygons(Array['COL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((43.2132267590001 -12.3803036439999,43.2132267590001 -11.3612606749999,44.5290633470001 -11.3612606749999,44.5290633470001 -12.3803036439999,43.2132267590001 -12.3803036439999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['COM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-25.3604223299999 14.8039411480001,-25.3604223299999 17.196600653,-22.6665746739999 17.196600653,-22.6665746739999 14.8039411480001,-25.3604223299999 14.8039411480001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CPV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-87.1176651679999 5.51508209800012,-87.1176651679999 11.2099370320002,-82.5628368739999 11.2099370320002,-82.5628368739999 5.51508209800012,-87.1176651679999 5.51508209800012))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CRI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((154.388519727 -21.0300432269999,154.388519727 -21.028741144,154.391286655 -21.028741144,154.391286655 -21.0300432269999,154.388519727 -21.0300432269999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CSI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-84.9496150379999 19.827826239,-84.9496150379999 23.2655703800001,-74.1328832669999 23.2655703800001,-74.1328832669999 19.827826239,-84.9496150379999 19.827826239))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CUB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-69.1717423169999 12.041327216,-69.1717423169999 12.3915062520001,-68.7397354809999 12.3915062520001,-68.7397354809999 12.041327216,-69.1717423169999 12.041327216))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CUW'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((105.581797722 -10.5660132789999,105.581797722 -10.4308407529998,105.714691602 -10.4308407529998,105.714691602 -10.5660132789999,105.581797722 -10.5660132789999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CXR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-81.4165420209999 19.2638636150001,-81.4165420209999 19.7576308370001,-79.7266426919999 19.7576308370001,-79.7266426919999 19.2638636150001,-81.4165420209999 19.2638636150001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CYM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.6019153500579 35.002722473,32.6019153500579 35.6919619810002,34.5925399100002 35.6919619810002,34.5925399100002 35.002722473,32.6019153500579 35.002722473))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CYN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.2717391290002 34.6250194300001,32.2717391290002 35.1870821302553,34.0991317070001 35.1870821302553,34.0991317070001 34.6250194300001,32.2717391290002 34.6250194300001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CYP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((12.076140991 48.557915752,12.076140991 51.0400123090001,18.8374337160001 51.0400123090001,18.8374337160001 48.557915752,12.076140991 48.557915752))', 4326), ST_Centroid((geocode_admin0_polygons(Array['CZE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((5.85248986800011 47.271120911,5.85248986800011 55.065334377,15.0220593670001 55.065334377,15.0220593670001 47.271120911,5.85248986800011 47.271120911))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DEU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((41.7491101480001 10.9298249310001,41.7491101480001 12.7079125020001,43.4187117850001 12.7079125020001,43.4187117850001 10.9298249310001,41.7491101480001 10.9298249310001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DJI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.4889216789999 15.201808986,-61.4889216789999 15.6338565120001,-61.249256965 15.6338565120001,-61.249256965 15.201808986,-61.4889216789999 15.201808986))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DMA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((8.09400475400008 54.5685895850001,8.09400475400008 57.7511660830001,15.1513778000001 57.7511660830001,15.1513778000001 54.5685895850001,8.09400475400008 54.5685895850001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DNK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-72.0098376059999 17.5455589860001,-72.0098376059999 19.9376895200001,-68.3286026679999 19.9376895200001,-68.3286026679999 17.5455589860001,-72.0098376059999 17.5455589860001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DOM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-8.68238521299992 18.9755612180001,-8.68238521299992 37.0939395200001,11.9688607170001 37.0939395200001,11.9688607170001 18.9755612180001,-8.68238521299992 18.9755612180001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['DZA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-92.0115860669999 -5.01137257899988,-92.0115860669999 1.66437409100016,-75.2272639579999 1.66437409100016,-75.2272639579999 -5.01137257899988,-92.0115860669999 -5.01137257899988))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ECU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((24.6883427320001 21.9943692020002,24.6883427320001 31.6564802100001,36.8991805350002 31.6564802100001,36.8991805350002 21.9943692020002,24.6883427320001 21.9943692020002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['EGY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((36.4236470950001 12.3600218710001,36.4236470950001 18.004828192,43.1238712900001 18.004828192,43.1238712900001 12.3600218710001,36.4236470950001 12.3600218710001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ERI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((33.6740991620001 34.937892971,33.6740991620001 35.1189944460001,33.9214742440001 35.1189944460001,33.9214742440001 34.937892971,33.6740991620001 34.937892971))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ESB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-18.1672257149999 27.6422386740001,-18.1672257149999 43.793443101,4.3370874360001 43.793443101,4.3370874360001 27.6422386740001,-18.1672257149999 27.6422386740001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ESP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((21.8323673840001 57.5158185830001,21.8323673840001 59.6708845070001,28.1864754640001 59.6708845070001,28.1864754640001 57.5158185830001,21.8323673840001 57.5158185830001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['EST'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.9897998450001 3.40333343500009,32.9897998450001 14.8795321660001,47.9791691490001 14.8795321660001,47.9791691490001 3.40333343500009,32.9897998450001 3.40333343500009))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ETH'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.62316451 59.811224677,20.62316451 70.0753103640001,31.5695247800001 70.0753103640001,31.5695247800001 59.811224677,20.62316451 59.811224677))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FIN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-180 -21.7111141909999,-180 -12.4752743469999,180 -12.4752743469999,180 -21.7111141909999,-180 -21.7111141909999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FJI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.3181860019999 -52.4065227259999,-61.3181860019999 -51.0277645809999,-57.7342830069999 -51.0277645809999,-57.7342830069999 -52.4065227259999,-61.3181860019999 -52.4065227259999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FLK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-54.6152921149999 2.11067332000013,-54.6152921149999 51.0875408834804,8.20030521600006 51.0875408834804,8.20030521600006 2.11067332000013,-54.6152921149999 2.11067332000013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FRA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-7.64415442599994 61.3941104190001,-7.64415442599994 62.3989118510001,-6.2757869129999 62.3989118510001,-6.2757869129999 61.3941104190001,-7.64415442599994 61.3941104190001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FRO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((138.063812696 0.918158270000148,138.063812696 9.77558014500013,163.046560092 9.77558014500013,163.046560092 0.918158270000148,138.063812696 0.918158270000148))', 4326), ST_Centroid((geocode_admin0_polygons(Array['FSM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((8.69556725400014 -3.93685618990304,8.69556725400014 2.32249501600009,14.4989905190001 2.32249501600009,14.4989905190001 -3.93685618990304,8.69556725400014 -3.93685618990304))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GAB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-13.6913142569999 49.9096133480001,-13.6913142569999 60.84788646,1.77116946700002 60.84788646,1.77116946700002 49.9096133480001,-13.6913142569999 49.9096133480001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GBR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((39.9859763554231 41.0441108200001,39.9859763554231 43.5758425900001,46.6948031010001 43.5758425900001,46.6948031010001 41.0441108200001,39.9859763554231 41.0441108200001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GEO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-2.67345130099989 49.4115664730001,-2.67345130099989 49.731390692,-2.17031816299993 49.731390692,-2.17031816299993 49.4115664730001,-2.67345130099989 49.4115664730001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GGY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-3.26250931799999 4.7371279970001,-3.26250931799999 11.162937317,1.18796838400004 11.162937317,1.18796838400004 4.7371279970001,-3.26250931799999 4.7371279970001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GHA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-5.35838675876349 36.1105003930001,-5.35838675876349 36.1411196720123,-5.33877348311998 36.1411196720123,-5.33877348311998 36.1105003930001,-5.35838675876349 36.1105003930001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GIB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-15.0811254549999 7.19020823200012,-15.0811254549999 12.673387757,-7.66244746999996 12.673387757,-7.66244746999996 7.19020823200012,-15.0811254549999 7.19020823200012))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GIN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.7978409499999 15.8469912780002,-61.7978409499999 16.513088283,-60.9892471999999 16.513088283,-60.9892471999999 15.8469912780002,-61.7978409499999 15.8469912780002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GLP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-16.8297013009999 13.0650088560001,-16.8297013009999 13.8199844360001,-13.8187125249999 13.8199844360001,-13.8187125249999 13.0650088560001,-16.8297013009999 13.0650088560001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GMB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-16.7284367771401 10.9276390650001,-16.7284367771401 12.6794339000001,-13.6607118329999 12.6794339000001,-13.6607118329999 10.9276390650001,-16.7284367771401 10.9276390650001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GNB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((5.61198978000007 -1.47568124799986,5.61198978000007 3.77240631700012,11.3363411870001 3.77240631700012,11.3363411870001 -1.47568124799986,5.61198978000007 -1.47568124799986))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GNQ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((19.6264754570001 34.8150088560001,19.6264754570001 41.7504759730001,28.2397567070001 41.7504759730001,28.2397567070001 34.8150088560001,19.6264754570001 34.8150088560001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GRC'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.7905167309999 12.0028343770001,-61.7905167309999 12.5297305360001,-61.4216202459999 12.5297305360001,-61.4216202459999 12.0028343770001,-61.7905167309999 12.0028343770001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GRD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-73.0572403639999 59.792629299,-73.0572403639999 83.6341006530001,-11.3768204419999 83.6341006530001,-11.3768204419999 59.792629299,-73.0572403639999 59.792629299))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GRL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-92.2462338320825 13.7289030478944,-92.2462338320825 17.8160195930001,-88.2209221351212 17.8160195930001,-88.2209221351212 13.7289030478944,-92.2462338320825 13.7289030478944))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GTM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-54.6152921149999 2.11067332000013,-54.6152921149999 5.74476537500011,-51.649037239 5.74476537500011,-51.649037239 2.11067332000013,-54.6152921149999 2.11067332000013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GUF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((144.624196811 13.2410342470001,144.624196811 13.6541201840001,144.95215905 13.6541201840001,144.95215905 13.2410342470001,144.624196811 13.2410342470001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GUM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.3967128089999 1.18582021100013,-61.3967128089999 8.55801015800012,-56.4818190109999 8.55801015800012,-56.4818190109999 1.18582021100013,-61.3967128089999 1.18582021100013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['GUY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((113.837331576 22.177069403,113.837331576 22.5639460320001,114.40129642 22.5639460320001,114.40129642 22.177069403,113.837331576 22.177069403))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HKG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((73.236013217 -53.1925595029999,73.236013217 -52.9616024719999,73.8121850920001 -52.9616024719999,73.8121850920001 -53.1925595029999,73.236013217 -53.1925595029999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HMD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-89.3637912599999 12.9797773240001,-89.3637912599999 17.4186465520001,-83.1304418609999 17.4186465520001,-83.1304418609999 12.9797773240001,-89.3637912599999 12.9797773240001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HND'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((13.5014754570001 42.4163272160001,13.5014754570001 46.5469790650001,19.4078381750001 46.5469790650001,19.4078381750001 42.4163272160001,13.5014754570001 42.4163272160001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HRV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-74.4891658189999 18.0259463560001,-74.4891658189999 20.08978913,-71.6391108809999 20.08978913,-71.6391108809999 18.0259463560001,-74.4891658189999 18.0259463560001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HTI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((16.0940352780001 45.741343486,16.0940352780001 48.5692328900001,22.8776005460001 48.5692328900001,22.8776005460001 45.741343486,16.0940352780001 45.741343486))', 4326), ST_Centroid((geocode_admin0_polygons(Array['HUN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((95.0127059250001 -10.9226213519998,95.0127059250001 5.9101016300001,140.977626994 5.9101016300001,140.977626994 -10.9226213519998,95.0127059250001 -10.9226213519998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IDN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-4.79015051999994 54.0569522160001,-4.79015051999994 54.4190127620001,-4.3119197259999 54.4190127620001,-4.3119197259999 54.0569522160001,-4.79015051999994 54.0569522160001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IMN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((68.1434025400001 6.74555084800015,68.1434025400001 35.4954055790001,97.3622530520001 35.4954055790001,97.3622530520001 6.74555084800015,68.1434025400001 6.74555084800015))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IND'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((96.82154382 -12.1999651,96.82154382 -10.43084075,105.7146916 -10.43084075,105.7146916 -12.1999651,96.82154382 -12.1999651))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IOA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((71.260996941 -7.43222421699987,71.260996941 -5.22698333099991,72.4946395190001 -5.22698333099991,72.4946395190001 -7.43222421699987,71.260996941 -7.43222421699987))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IOT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-10.4781794909999 51.4457054710001,-10.4781794909999 55.386379299,-5.99351966099994 55.386379299,-5.99351966099994 51.4457054710001,-10.4781794909999 51.4457054710001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IRL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((44.0148633220001 25.0594081650001,44.0148633220001 39.7715269980001,63.3196281330001 39.7715269980001,63.3196281330001 25.0594081650001,44.0148633220001 25.0594081650001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IRN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((38.7745113520001 29.063136699,38.7745113520001 37.3754975380001,48.5592554050001 37.3754975380001,48.5592554050001 29.063136699,38.7745113520001 29.063136699))', 4326), ST_Centroid((geocode_admin0_polygons(Array['IRQ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-24.539906379 63.3967145850001,-24.539906379 66.564154364,-13.5029190749999 66.564154364,-13.5029190749999 63.3967145850001,-24.539906379 63.3967145850001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ISL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((34.2483508570001 29.4896914730001,34.2483508570001 33.4067217000001,35.8880725500002 33.4067217000001,35.8880725500002 29.4896914730001,34.2483508570001 29.4896914730001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ISR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((6.60272831200007 35.489243882,6.60272831200007 47.085214945,18.5174259770001 47.085214945,18.5174259770001 35.489243882,6.60272831200007 35.489243882))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ITA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-78.3746638659999 17.70319245,-78.3746638659999 18.525091864,-76.1879776679999 18.525091864,-76.1879776679999 17.70319245,-78.3746638659999 17.70319245))', 4326), ST_Centroid((geocode_admin0_polygons(Array['JAM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-2.24201412699992 49.1713320980001,-2.24201412699992 49.267035223,-2.00829016799992 49.267035223,-2.00829016799992 49.1713320980001,-2.24201412699992 49.1713320980001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['JEY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((34.949385116681 29.189950664,34.949385116681 33.3716850790001,39.2919991450001 33.3716850790001,39.2919991450001 29.189950664,34.949385116681 29.189950664))', 4326), ST_Centroid((geocode_admin0_polygons(Array['JOR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((122.938161655 24.212103583,122.938161655 45.5204125020001,153.985606316 45.5204125020001,153.985606316 24.212103583,122.938161655 24.212103583))', 4326), ST_Centroid((geocode_admin0_polygons(Array['JPN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((62.8006417230001 45.5658244830001,62.8006417230001 46.390838725,63.9671338300001 46.390838725,63.9671338300001 45.5658244830001,62.8006417230001 45.5658244830001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KAB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((76.7773507410001 35.110441997,76.7773507410001 35.6477993780001,77.8003463140001 35.6477993780001,77.8003463140001 35.110441997,76.7773507410001 35.110441997))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KAS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((46.478278849 40.5846556600001,46.478278849 55.4345502730001,87.3237960210001 55.4345502730001,87.3237960210001 40.5846556600001,46.478278849 40.5846556600001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KAZ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((33.8904683840002 -4.67750416499996,33.8904683840002 5.03037582260775,41.8850191650001 5.03037582260775,41.8850191650001 -4.67750416499996,33.8904683840002 -4.67750416499996))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KEN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((69.2262960200001 39.1892369590001,69.2262960200001 43.2617015580001,80.2575606690001 43.2617015580001,80.2575606690001 39.1892369590001,69.2262960200001 39.1892369590001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KGZ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((102.313423706 10.4157736200001,102.313423706 14.7045816050001,107.610516399 14.7045816050001,107.610516399 10.4157736200001,102.313423706 10.4157736200001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KHM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-174.543405728 -11.4611141909999,-174.543405728 4.7230899110001,176.850922071 4.7230899110001,176.850922071 -11.4611141909999,-174.543405728 -11.4611141909999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KIR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-62.8610733709999 17.1005313170001,-62.8610733709999 17.4158389340001,-62.5367732409999 17.4158389340001,-62.5367732409999 17.1005313170001,-62.8610733709999 17.1005313170001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KNA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((124.613617384 33.197577216,124.613617384 38.6243307589749,131.862521886 38.6243307589749,131.862521886 33.197577216,124.613617384 33.197577216))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KOR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.024751424 41.8440103160001,20.024751424 43.2630709840001,21.7727584220001 43.2630709840001,21.7727584220001 41.8440103160001,20.024751424 41.8440103160001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KOS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((46.5324357500001 28.5335049440001,46.5324357500001 30.0982156370001,48.4327812271219 30.0982156370001,48.4327812271219 28.5335049440001,46.5324357500001 28.5335049440001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['KWT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((100.097073202 13.9154566450001,100.097073202 22.4960440070001,107.66436324 22.4960440070001,107.66436324 13.9154566450001,100.097073202 13.9154566450001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LAO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((35.0996199880001 33.055580342,35.0996199880001 34.687547913,36.604101196 34.687547913,36.604101196 33.055580342,35.0996199880001 33.055580342))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LBN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-11.4761856759999 4.34723541900004,-11.4761856759999 8.56539560900008,-7.38411820499996 8.56539560900008,-7.38411820499996 4.34723541900004,-11.4761856759999 4.34723541900004))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LBR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((9.28654382300007 19.496123759,9.28654382300007 33.1812253147281,25.1562606130001 33.1812253147281,25.1562606130001 19.496123759,9.28654382300007 19.496123759))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LBY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.078521288 13.7146670590001,-61.078521288 14.1118838560001,-60.8829646479999 14.1118838560001,-60.8829646479999 13.7146670590001,-61.078521288 13.7146670590001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LCA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((9.47588627100012 47.0524004120001,9.47588627100012 47.2628010050001,9.61572269700011 47.2628010050001,9.61572269700011 47.0524004120001,9.47588627100012 47.0524004120001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LIE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((79.6557723320001 5.92373281500015,79.6557723320001 9.82957591400015,81.8903100920001 9.82957591400015,81.8903100920001 5.92373281500015,79.6557723320001 5.92373281500015))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LKA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((27.0021549890001 -30.6587993359999,27.0021549890001 -28.570761414,29.4359082440001 -28.570761414,29.4359082440001 -30.6587993359999,27.0021549890001 -30.6587993359999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LSO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.9245687005624 53.8868411260001,20.9245687005624 56.4426024370001,26.8007202560001 56.4426024370001,26.8007202560001 53.8868411260001,20.9245687005624 53.8868411260001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LTU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((5.71492720500004 49.441324362,5.71492720500004 50.1749746710001,6.50257938700014 50.1749746710001,6.50257938700014 49.441324362,5.71492720500004 49.441324362))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LUX'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.9685978520001 55.6669908660001,20.9685978520001 58.0751384490001,28.2172746170001 58.0751384490001,28.2172746170001 55.6669908660001,20.9685978520001 55.6669908660001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['LVA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((113.519867384 22.1053734400001,113.519867384 22.220770575,113.587494337 22.220770575,113.587494337 22.1053734400001,113.519867384 22.1053734400001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MAC'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-63.1468399729999 18.0333914721357,-63.1468399729999 18.1221377620001,-63.0107315749999 18.1221377620001,-63.0107315749999 18.0333914721357,-63.1468399729999 18.0333914721357))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MAF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-17.0137433253452 21.4199710975817,-17.0137433253452 35.926519149,-1.03199947099995 35.926519149,-1.03199947099995 21.4199710975817,-17.0137433253452 21.4199710975817))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MAR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((7.36575020700008 43.7179690770001,7.36575020700008 43.763505554,7.4374540320631 43.763505554,7.4374540320631 43.7179690770001,7.36575020700008 43.7179690770001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MCO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((26.617889038 45.461773987,26.617889038 48.486033834,30.1315763750001 48.486033834,30.1315763750001 45.461773987,26.617889038 45.461773987))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MDA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((43.2229110040001 -25.5985653629998,43.2229110040001 -11.9436174459998,50.5039168630001 -11.9436174459998,50.5039168630001 -25.5985653629998,43.2229110040001 -25.5985653629998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MDG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((72.684825066 -0.688571872999901,72.684825066 7.10724518400015,73.7531844410002 7.10724518400015,73.7531844410002 -0.688571872999901,72.684825066 -0.688571872999901))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MDV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-118.368804229 14.5462829243643,-118.368804229 32.7128364050001,-86.7005916009999 32.7128364050001,-86.7005916009999 14.5462829243643,-118.368804229 14.5462829243643))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MEX'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((165.282237175 4.57379791900016,165.282237175 14.6105003930001,172.029795769 14.6105003930001,172.029795769 4.57379791900016,165.282237175 4.57379791900016))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MHL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.4441573490001 40.8493940230001,20.4441573490001 42.3703347790001,23.0095821530001 42.3703347790001,23.0095821530001 40.8493940230001,20.4441573490001 40.8493940230001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MKD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-12.2641304119999 10.1400540170001,-12.2641304119999 24.9950645960001,4.23563765500012 24.9950645960001,4.23563765500012 10.1400540170001,-12.2641304119999 10.1400540170001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MLI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((14.1836043630001 35.801214911,14.1836043630001 36.0755882830001,14.5671492850001 36.0755882830001,14.5671492850001 35.801214911,14.1836043630001 35.801214911))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MLT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((92.174972779 9.79071686400013,92.174972779 28.538465881,101.173855021 28.538465881,101.173855021 9.79071686400013,92.174972779 9.79071686400013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MMR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((18.4335307210001 41.852362372,18.4335307210001 43.5478856410001,20.3551705320001 43.5478856410001,20.3551705320001 41.852362372,18.4335307210001 41.852362372))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MNE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((87.7357088630001 41.586144918,87.7357088630001 52.1295840460001,119.907026815 52.1295840460001,119.907026815 41.586144918,87.7357088630001 41.586144918))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MNG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((144.902110222 14.1106631530001,144.902110222 20.5554059920001,145.868907097 20.5554059920001,145.868907097 14.1106631530001,144.902110222 14.1106631530001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MNP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((30.2138452550002 -26.8602715039999,30.2138452550002 -10.4690080709999,40.8479923840001 -10.4690080709999,40.8479923840001 -26.8602715039999,30.2138452550002 -26.8602715039999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MOZ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-17.0811748859999 14.7343989060002,-17.0811748859999 27.2854157510001,-4.8216131179999 27.2854157510001,-4.8216131179999 14.7343989060002,-17.0811748859999 14.7343989060002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MRT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-62.2301326159999 16.6753604190001,-62.2301326159999 16.8193220070001,-62.1405330069999 16.8193220070001,-62.1405330069999 16.6753604190001,-62.2301326159999 16.6753604190001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MSR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.228830533 14.4081078150001,-61.228830533 14.8768985050001,-60.8104141919999 14.8768985050001,-60.8104141919999 14.4081078150001,-61.228830533 14.4081078150001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MTQ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((56.5241805350002 -20.5173479149999,56.5241805350002 -10.3239071589999,63.493907097 -10.3239071589999,63.493907097 -20.5173479149999,56.5241805350002 -20.5173479149999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MUS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.6633081470002 -17.1353353879999,32.6633081470002 -9.38123504699981,35.9042989500001 -9.38123504699981,35.9042989500001 -17.1353353879999,32.6633081470002 -17.1353353879999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MWI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((99.6452280600001 0.851370341000077,99.6452280600001 7.35578034100014,119.278086785 7.35578034100014,119.278086785 0.851370341000077,99.6452280600001 0.851370341000077))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MYS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((45.0424910820001 -12.9891903629999,45.0424910820001 -12.6472307269999,45.2908634770001 -12.6472307269999,45.2908634770001 -12.9891903629999,45.0424910820001 -12.9891903629999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['MYT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((11.7176212900001 -28.9593681839999,11.7176212900001 -16.9510572309999,25.2597807210001 -16.9510572309999,25.2597807210001 -28.9593681839999,11.7176212900001 -28.9593681839999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NAM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((163.615733269 -22.6706682269998,163.615733269 -19.623711847,171.343765287 -19.623711847,171.343765287 -22.6706682269998,163.615733269 -22.6706682269998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NCL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((0.152941121000111 11.69577301,0.152941121000111 23.5173511760001,15.9703218990001 23.5173511760001,15.9703218990001 11.69577301,0.152941121000111 11.69577301))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NER'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((167.912119988 -29.0800106749999,167.912119988 -28.9974911439999,167.996348504 -28.9974911439999,167.996348504 -29.0800106749999,167.912119988 -29.0800106749999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NFK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((2.67108199000012 4.27216217700007,2.67108199000012 13.8802908320001,14.6699361570001 13.8802908320001,14.6699361570001 4.27216217700007,2.67108199000012 4.27216217700007))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NGA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-87.6858210929999 10.7134815470002,-87.6858210929999 15.0309699500002,-82.7256973949999 15.0309699500002,-82.7256973949999 10.7134815470002,-87.6858210929999 10.7134815470002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NIC'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-169.95042884 -19.1427548159999,-169.95042884 -18.9640438779999,-169.782907681 -18.9640438779999,-169.782907681 -19.1427548159999,-169.95042884 -19.1427548159999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NIU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-63.2513321609999 17.4645711740002,-63.2513321609999 53.5580915390001,7.19850590000004 53.5580915390001,7.19850590000004 17.4645711740002,-63.2513321609999 17.4645711740002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NLD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-9.11742102799991 57.993150132,-9.11742102799991 80.2481143250001,33.6403914720001 80.2481143250001,33.6403914720001 57.993150132,-9.11742102799991 57.993150132))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NOR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((80.03028772 26.3437678020001,80.03028772 30.4169041950001,88.1690674240001 30.4169041950001,88.1690674240001 26.3437678020001,80.03028772 26.3437678020001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NPL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((166.906993035 -0.551853122999901,166.906993035 -0.490411065999922,166.958262566 -0.490411065999922,166.958262566 -0.551853122999901,166.906993035 -0.551853122999901))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NRU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-177.9579972 -52.600313271,-177.9579972 -8.54322682099986,178.843923373 -8.54322682099986,178.843923373 -52.600313271,-177.9579972 -52.600313271))', 4326), ST_Centroid((geocode_admin0_polygons(Array['NZL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((51.9786149500002 16.6424060302812,51.9786149500002 26.385972398,59.8445744150001 26.385972398,59.8445744150001 16.6424060302812,51.9786149500002 16.6424060302812))', 4326), ST_Centroid((geocode_admin0_polygons(Array['OMN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((60.8443787030001 23.6945254580001,60.8443787030001 37.0544835410001,77.0489709880002 37.0544835410001,77.0489709880002 23.6945254580001,60.8443787030001 23.6945254580001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PAK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-83.053246217 7.20571523600016,-83.053246217 9.62929248000016,-77.1632698159999 9.62929248000016,-77.1632698159999 7.20571523600016,-83.053246217 7.20571523600016))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PAN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-130.753081835 -25.0770809879998,-130.753081835 -23.9244117169999,-124.778065559 -23.9244117169999,-124.778065559 -25.0770809879998,-130.753081835 -25.0770809879998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PCN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-81.3375575289999 -18.3377462069379,-81.3375575289999 -0.0290927119998656,-68.6842524829999 -0.0290927119998656,-68.6842524829999 -18.3377462069379,-81.3375575289999 -18.3377462069379))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PER'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((114.027679884 9.67951080900016,114.027679884 11.1179873720002,115.848806186 11.1179873720002,115.848806186 9.67951080900016,114.027679884 9.67951080900016))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PGA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((116.954925977 4.65570709800011,116.954925977 21.122381903,126.617686394 21.122381903,126.617686394 4.65570709800011,116.954925977 4.65570709800011))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PHL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((131.131114129 2.94904205900015,131.131114129 8.09661782863144,134.727342990799 8.09661782863144,134.727342990799 2.94904205900015,131.131114129 2.94904205900015))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PLW'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((140.84921106 -11.6363257789998,140.84921106 -1.34636809699988,155.96753991 -1.34636809699988,155.96753991 -11.6363257789998,140.84921106 -11.6363257789998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PNG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((14.123922973 48.9940131640001,14.123922973 54.8383242860001,24.1431563720001 54.8383242860001,24.1431563720001 48.9940131640001,14.123922973 48.9940131640001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['POL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-67.9378149079999 17.9229190120002,-67.9378149079999 18.522772528,-65.2446182929999 18.522772528,-65.2446182929999 17.9229190120002,-67.9378149079999 17.9229190120002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PRI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((124.211315989 37.6756045590001,124.211315989 43.010269878,130.699961785 43.010269878,130.699961785 37.6756045590001,124.211315989 37.6756045590001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PRK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-31.2849014959999 30.0292422550001,-31.2849014959999 42.15362966,-6.20594722499993 42.15362966,-6.20594722499993 30.0292422550001,-31.2849014959999 30.0292422550001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PRT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-62.650357219 -27.5868421429999,-62.650357219 -19.2867286169999,-54.2452888589999 -19.2867286169999,-54.2452888589999 -27.5868421429999,-62.650357219 -27.5868421429999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PRY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((34.2002694411415 31.2114489580001,34.2002694411415 32.542640076,35.5725362550001 32.542640076,35.5725362550001 31.2114489580001,34.2002694411415 31.2114489580001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PSX'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-154.536976692 -27.6412085919999,-154.536976692 -7.95012786299982,-134.942982551 -7.95012786299982,-134.942982551 -27.6412085919999,-154.536976692 -27.6412085919999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['PYF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((50.750987175 24.5598715210001,50.750987175 26.16010163,51.6165470710001 26.16010163,51.6165470710001 24.5598715210001,50.750987175 24.5598715210001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['QAT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((55.2254337900002 -21.3707821589999,55.2254337900002 -20.861423435,55.8545028000001 -20.861423435,55.8545028000001 -21.3707821589999,55.2254337900002 -21.3707821589999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['REU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((20.2428259690001 43.6500499480001,20.2428259690001 48.2748322560001,29.6995548840001 48.2748322560001,29.6995548840001 43.6500499480001,20.2428259690001 43.6500499480001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ROU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-180 41.1926805620002,-180 81.8587100280001,180 81.8587100280001,180 41.1926805620002,-180 41.1926805620002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['RUS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((28.8572355550001 -2.82685475699989,28.8572355550001 -1.05869394899987,30.8878092850001 -1.05869394899987,30.8878092850001 -2.82685475699989,28.8572355550001 -2.82685475699989))', 4326), ST_Centroid((geocode_admin0_polygons(Array['RWA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-17.1046443349999 20.7669131530001,-17.1046443349999 27.6614653400001,-8.68080908199988 27.6614653400001,-8.68080908199988 20.7669131530001,-17.1046443349999 20.7669131530001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SAH'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((34.5727645190002 16.3709446840655,34.5727645190002 32.1213479620001,55.6375647380002 32.1213479620001,55.6375647380002 16.3709446840655,34.5727645190002 16.3709446840655))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SAU'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((117.751856381 15.1500820250001,117.751856381 15.1543692630001,117.755692331 15.1543692630001,117.755692331 15.1500820250001,117.751856381 15.1500820250001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SCR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((21.8094486900001 8.6816417440001,21.8094486900001 22.2269648230001,38.6038517590002 22.2269648230001,38.6038517590002 8.6816417440001,21.8094486900001 8.6816417440001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SDN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((24.1215556230001 3.49020151800015,24.1215556230001 12.2161546840002,35.9208354090002 12.2161546840002,35.9208354090002 3.49020151800015,24.1215556230001 3.49020151800015))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SDS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-17.5360408189999 12.3056065880001,-17.5360408189999 16.6913853970001,-11.3777762449999 16.6913853970001,-11.3777762449999 12.3056065880001,-17.5360408189999 12.3056065880001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SEN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-78.6404109369999 15.8620873070001,-78.6404109369999 15.8672956400001,-78.6368708979999 15.8672956400001,-78.6368708979999 15.8620873070001,-78.6404109369999 15.8620873070001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SER'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((103.640391472 1.26430898600009,103.640391472 1.44863515800004,104.003428582 1.44863515800004,104.003428582 1.26430898600009,103.640391472 1.26430898600009))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SGP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-38.0870255199999 -59.4727515599998,-38.0870255199999 -53.9724260399999,-26.2393285799999 -53.9724260399999,-26.2393285799999 -59.4727515599998,-38.0870255199999 -59.4727515599998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SGS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-14.4177139959999 -40.3978817689998,-14.4177139959999 -7.87786223799983,-5.65038001199986 -7.87786223799983,-5.65038001199986 -40.3978817689998,-14.4177139959999 -40.3978817689998))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SHN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((10.4843856130001 76.4364688170001,10.4843856130001 80.7700869810001,29.7070418630001 80.7700869810001,29.7070418630001 76.4364688170001,10.4843856130001 76.4364688170001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SJM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((155.507985873 -12.2906226539999,155.507985873 -6.59986744599981,168.825856967 -6.59986744599981,168.825856967 -12.2906226539999,155.507985873 -12.2906226539999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SLB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-13.3010961579999 6.91941966400012,-13.3010961579999 9.99600596100012,-10.2822358799999 9.99600596100012,-10.2822358799999 6.91941966400012,-13.3010961579999 6.91941966400012))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SLE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-90.1147790119999 13.1586367860001,-90.1147790119999 14.4453726200001,-87.6931935119999 14.4453726200001,-87.6931935119999 13.1586367860001,-90.1147790119999 13.1586367860001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SLV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((12.3856287450001 43.892055515,12.3856287450001 43.9825667860001,12.4923922540001 43.9825667860001,12.4923922540001 43.892055515,12.3856287450001 43.892055515))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SMR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((42.6472465410002 7.9965156050001,42.6472465410002 11.4989281270001,48.9391119999082 11.4989281270001,48.9391119999082 7.9965156050001,42.6472465410002 7.9965156050001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SOL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((40.9653853760002 -1.69628316497764,40.9653853760002 11.9891186460002,51.4170378110001 11.9891186460002,51.4170378110001 -1.69628316497764,40.9653853760002 -1.69628316497764))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SOM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-56.396595832 46.7527529970001,-56.396595832 47.1412621110001,-56.1447647779999 47.1412621110001,-56.1447647779999 46.7527529970001,-56.396595832 46.7527529970001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SPM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((18.8449784750001 42.2349425250001,18.8449784750001 46.1738752240001,22.9845707600001 46.1738752240001,22.9845707600001 42.2349425250001,18.8449784750001 42.2349425250001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SRB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((6.46168053500011 0.0241153020000695,6.46168053500011 1.69977448100016,7.46273847700007 1.69977448100016,7.46273847700007 0.0241153020000695,6.46168053500011 0.0241153020000695))', 4326), ST_Centroid((geocode_admin0_polygons(Array['STP'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-58.0676912029999 1.83350677500007,-58.0676912029999 6.01157376600012,-53.9863574539999 6.01157376600012,-53.9863574539999 1.83350677500007,-58.0676912029999 1.83350677500007))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SUR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((16.8444804280001 47.7500064090001,16.8444804280001 49.601779684,22.5396366780001 49.601779684,22.5396366780001 47.7500064090001,16.8444804280001 47.7500064090001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SVK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((13.3652612710001 45.42363678,13.3652612710001 46.863962301,16.5153015540001 46.863962301,16.5153015540001 45.42363678,13.3652612710001 45.42363678))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SVN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((11.1081649100001 55.3426781270001,11.1081649100001 69.0363556930001,24.1634135340001 69.0363556930001,24.1634135340001 55.3426781270001,11.1081649100001 55.3426781270001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SWE'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((30.7829061280001 -27.3162643429999,30.7829061280001 -25.7359990439999,32.1173983160001 -25.7359990439999,32.1173983160001 -27.3162643429999,30.7829061280001 -27.3162643429999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SWZ'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-63.1188858709999 18.019110419,-63.1188858709999 18.0621092720001,-63.0175685850526 18.0621092720001,-63.0175685850526 18.019110419,-63.1188858709999 18.019110419))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SXM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((46.2073673840002 -9.75554778399989,46.2073673840002 -3.79111093499991,56.2874455090001 -3.79111093499991,56.2874455090001 -9.75554778399989,46.2073673840002 -9.75554778399989))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SYC'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((35.7233992850002 32.313041687,35.7233992850002 37.3249063110001,42.377185506 37.3249063110001,42.377185506 32.313041687,35.7233992850002 32.313041687))', 4326), ST_Centroid((geocode_admin0_polygons(Array['SYR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-72.481312629 21.2901065120001,-72.481312629 21.9592145850001,-71.1288956369999 21.9592145850001,-71.1288956369999 21.2901065120001,-72.481312629 21.2901065120001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TCA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((13.4491837970001 7.45556671100012,13.4491837970001 23.4447199510001,23.9844063720001 23.4447199510001,23.9844063720001 7.45556671100012,13.4491837970001 7.45556671100012))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TCD'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-0.16610917099996 6.100490848287,-0.16610917099996 11.1349803670001,1.78235070800014 11.1349803670001,1.78235070800014 6.100490848287,-0.16610917099996 6.100490848287))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TGO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((97.3514010010001 5.62989003500013,97.3514010010001 20.4450064090001,105.650997762 20.4450064090001,105.650997762 5.62989003500013,97.3514010010001 5.62989003500013))', 4326), ST_Centroid((geocode_admin0_polygons(Array['THA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((67.3426900630002 36.6786408490002,67.3426900630002 41.0399767050001,75.1641247970001 41.0399767050001,75.1641247970001 36.6786408490002,67.3426900630002 36.6786408490002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TJK'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-171.086537239 -11.0660946589999,-171.086537239 -11.0513648419999,-171.072824674 -11.0513648419999,-171.072824674 -11.0660946589999,-171.086537239 -11.0660946589999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TKL'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((52.4376706173443 35.140646871,52.4376706173443 42.791187643,66.6457816980001 42.791187643,66.6457816980001 35.140646871,52.4376706173443 35.140646871))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TKM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((124.03003991 -9.5012277219999,124.03003991 -8.13502369599983,127.313243035 -8.13502369599983,127.313243035 -9.5012277219999,124.03003991 -9.5012277219999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TLS'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-176.219309049 -22.3387997379999,-176.219309049 -15.5595028629999,-173.914255338 -15.5595028629999,-173.914255338 -22.3387997379999,-176.219309049 -22.3387997379999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TON'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.9287003249999 10.0420596370002,-61.9287003249999 11.3510602890001,-60.5220841139999 11.3510602890001,-60.5220841139999 10.0420596370002,-61.9287003249999 10.0420596370002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TTO'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((7.4798323980001 30.2289053350001,7.4798323980001 37.3452009140002,11.5641309000001 37.3452009140002,11.5641309000001 30.2289053350001,7.4798323980001 30.2289053350001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TUN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((25.663259311 35.819778545,25.663259311 42.0987816430001,44.8069928290001 42.0987816430001,44.8069928290001 35.819778545,25.663259311 35.819778545))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TUR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((176.125254754 -9.42066822699981,176.125254754 -5.67750416499986,179.906748894 -5.67750416499986,179.906748894 -9.42066822699981,176.125254754 -9.42066822699981))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TUV'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((118.279551629 21.9046084660001,118.279551629 25.287420966,122.005381707 25.287420966,122.005381707 21.9046084660001,118.279551629 21.9046084660001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TWN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((29.3210315350001 -11.7312724819999,29.3210315350001 -0.985830179999823,40.4493921230001 -0.985830179999823,40.4493921230001 -11.7312724819999,29.3210315350001 -11.7312724819999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['TZA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((29.5484595130001 -1.47520599399984,29.5484595130001 4.21969187500011,35.0064726150001 4.21969187500011,35.0064726150001 -1.47520599399984,29.5484595130001 -1.47520599399984))', 4326), ST_Centroid((geocode_admin0_polygons(Array['UGA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((22.1328398030001 44.381048895,22.1328398030001 52.3689492800001,40.1595430910002 52.3689492800001,40.1595430910002 44.381048895,22.1328398030001 44.381048895))', 4326), ST_Centroid((geocode_admin0_polygons(Array['UKR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-177.389597134 -0.388767184999892,-177.389597134 28.2153181010001,166.652354363 28.2153181010001,166.652354363 -0.388767184999892,-177.389597134 -0.388767184999892))', 4326), ST_Centroid((geocode_admin0_polygons(Array['UMI'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-58.4393611319999 -34.9734026019999,-58.4393611319999 -30.0968698119999,-53.1108361419999 -30.0968698119999,-53.1108361419999 -34.9734026019999,-58.4393611319999 -34.9734026019999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['URY'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-179.143503384 18.9061171430001,-179.143503384 71.4125023460001,179.780935092 71.4125023460001,179.780935092 18.9061171430001,-179.143503384 18.9061171430001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['USA'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-75.2328569552957 19.8911422360002,-75.2328569552957 19.9715836900001,-75.0949502909999 19.9715836900001,-75.0949502909999 19.8911422360002,-75.2328569552957 19.8911422360002))', 4326), ST_Centroid((geocode_admin0_polygons(Array['USG'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((55.9758386630001 37.1851474,55.9758386630001 45.5587189740001,73.1486405840002 45.5587189740001,73.1486405840002 37.1851474,55.9758386630001 37.1851474))', 4326), ST_Centroid((geocode_admin0_polygons(Array['UZB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((12.4527140820001 41.9027519410001,12.4527140820001 41.9039147380001,12.4540354420001 41.9039147380001,12.4540354420001 41.9027519410001,12.4527140820001 41.9027519410001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VAT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-61.4598282539999 12.5851504580001,-61.4598282539999 13.3807640650001,-61.1239314439999 13.3807640650001,-61.1239314439999 12.5851504580001,-61.4598282539999 12.5851504580001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VCT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-73.3911486409999 0.649315491000067,-73.3911486409999 15.7029483090001,-59.815594849 15.7029483090001,-59.815594849 0.649315491000067,-73.3911486409999 0.649315491000067))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VEN'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-64.7739965489999 18.3346621770001,-64.7739965489999 18.74624258,-64.2707413399999 18.74624258,-64.2707413399999 18.3346621770001,-64.7739965489999 18.3346621770001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VGB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-65.0414934419999 17.6827660180001,-65.0414934419999 18.3865986140001,-64.5593969389999 18.3865986140001,-64.5593969389999 17.6827660180001,-65.0414934419999 17.6827660180001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VIR'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((102.118655233 8.56557851800015,102.118655233 23.3662751270001,109.472422722 23.3662751270001,109.472422722 8.56557851800015,102.118655233 8.56557851800015))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VNM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((166.520518425 -20.2531063779999,166.520518425 -13.0648739559998,169.898936394 -13.0648739559998,169.898936394 -20.2531063779999,166.520518425 -20.2531063779999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['VUT'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-178.185739713 -14.3194312479999,-178.185739713 -13.208916925,-176.125599739 -13.208916925,-176.125599739 -14.3194312479999,-178.185739713 -14.3194312479999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['WLF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((32.7601022650002 34.5685488950001,32.7601022650002 34.7009482940001,33.03028405 34.7009482940001,33.03028405 34.5685488950001,32.7601022650002 34.5685488950001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['WSB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((-172.782582161 -14.052829685,-172.782582161 -13.4628231749999,-171.437692838 -13.4628231749999,-171.437692838 -14.052829685,-172.782582161 -14.052829685))', 4326), ST_Centroid((geocode_admin0_polygons(Array['WSM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((42.5457462900001 12.1114436720001,42.5457462900001 18.9956375130001,54.5402938160002 18.9956375130001,54.5402938160002 12.1114436720001,42.5457462900001 12.1114436720001))', 4326), ST_Centroid((geocode_admin0_polygons(Array['YEM'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((16.4699813160001 -46.965752863,16.4699813160001 -22.1264519249999,37.9777938160001 -22.1264519249999,37.9777938160001 -46.965752863,16.4699813160001 -46.965752863))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ZAF'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((21.9798775630001 -18.0692318719999,21.9798775630001 -8.1941240429999,33.674202515 -8.1941240429999,33.674202515 -18.0692318719999,21.9798775630001 -18.0692318719999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ZMB'])).geom))" should true
    sql "SELECT ST_Intersects(ST_GeomFromText('POLYGON((25.219369751 -22.3973397829999,25.219369751 -15.6148080449999,33.0427681890002 -15.6148080449999,33.0427681890002 -22.3973397829999,25.219369751 -22.3973397829999))', 4326), ST_Centroid((geocode_admin0_polygons(Array['ZWE'])).geom))" should true

}


#################################################### TESTS END HERE ####################################################
