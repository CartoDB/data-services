#!/bin/sh

#################################################### TESTS GO HERE ####################################################
function test_geocoding_functions_namedplace() {
    # checks that the result is false and no geometry is returned for a non-recognised named place
    sql "SELECT (geocode_namedplace(Array['Null island is not an island'])).success" should false
    sql "SELECT (geocode_namedplace(Array['Null island is not an island'])).geom is null" should true
    
    # check that the returned geometry is a point
    sql "SELECT ST_GeometryType((geocode_namedplace(Array['Elx'])).geom)" should ST_Point

    # big cities: more than 1 million inhabitants from populated places (some coordinates have been adjusted)
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'NY', 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], null, 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Patna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(85.1280927552218, 25.6269049843829, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Karaj'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(50.9680589822987, 35.8023045612465, 4326)::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Minsk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(27.5646812966582, 53.9019232950431, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toronto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.4219666529884, 43.7019257364084, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Recife'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-34.9175513696073, -8.07369946724924, 4326)::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Vegas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.221952004694, 36.2119436400243, 4326)::geography,10000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bursa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(29.0680520648935, 40.2019326537123, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montréal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-73.5852428167021, 45.501945064215, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dhaka'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(90.4066336081075, 23.7250055703128, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hangzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.168072817211, 30.2519198362895, 4326)::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sheffield'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.49999658345183, 53.3666766551778, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Córdoba'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-64.1842404159484, -31.3980122114831, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Istanbul'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.94966, 41.01384, 4326)::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Birmingham'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.92194264551705, 52.4769198363784, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rawalpindi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(73.0380813619443, 33.6019220742585, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Harbin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.648039044451, 45.7519298054271, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Suzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.618071189609, 31.302424190135, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Houston'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-95.34327, 29.76328, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Shiraz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(52.53113, 29.61031, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Glasgow'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.25265309474497, 55.8763505818347, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Shantou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(116.71479, 23.36814, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Karachi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(67.0822, 24.9056, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Philadelphia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.1719418320079, 39.95233, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Buenos Aires'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-58.3994772323314, -34.6005557499074, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xiantao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.438096010543, 30.3723517617456, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanaa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(44.2046475239384, 15.3566791542636, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ufa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(56.0380854308868, 54.7919206501896, 4326) ::geography,10000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maputo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(32.5872171039701, -25.953331628779, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baotou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(109.820073956493, 40.6541531126984, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guangzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.25, 23.11667, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sapporo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(141.338098452061, 43.0769251260542, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cape Town'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(18.433042299226, -33.9180651086287, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kiev'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(30.5146821104722, 50.4353131876072, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chongqing'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.55278, 29.56278, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monrovia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-10.7996604367759, 6.31458164716014, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ouagadougou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.52666961491644, 12.3722618365434, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Frankfurt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.53333, 49.68333, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rio de Janeiro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-43.2075, -22.90278, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Khulna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(89.5580549134426, 22.8419328570932, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jerusalem'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(35.2066259345986, 31.7784078155733, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montevideo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-56.18816, -34.90328, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ottawa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.7019611598095, 45.4186426553604, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Goiania'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-49.25389, -16.67861, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haiphong'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.68345, 20.86481, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Raleigh'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-78.63861, 35.7721, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guiyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.718092755308, 26.5819888060014, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Providence'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.4169255559512, 41.8230481729243, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tashkent'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(69.21627, 41.26465, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Diego'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.15726, 32.71533, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pyongyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(125.752744854994, 39.0213845580043, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chifeng'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.948043927232, 42.271961340244, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dubai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(55.17128, 25.0657, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maoming'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(110.9, 21.65, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barcelona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.18142446061915, 41.3852454385475, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Jose'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-121.89496, 37.33939, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gujranwala'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(75.21138, 30.49972, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Conakry'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.6821808861239, 9.53346870502179, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Long Beach'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-118.18923, 33.76696, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanchang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(115.878050437637, 28.6819381468301, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lima'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-77.0520079534347, -12.0460668175256, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Incheon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.70515, 37.45646, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xiangtan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.900023151706, 27.8504305206357, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Budapest'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(19.0813748187597, 47.5019521849913, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xiangfan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.128098451944, 32.0219409951506, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Izmir'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(27.1498481518493, 38.4380955409497, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amsterdam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.91469431740097, 52.3519145466644, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Bernardino'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.301980080874, 34.1223295856538, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Irvine'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.829950197198, 33.6804105825079, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Meerut'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(77.6980553202963, 29.0023578652559, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jamshedpur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(86.1955728170751, 22.7894812783169, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yokohama'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(139.6425, 35.44778, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kyoto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(135.74805206532, 35.0319381468556, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Paz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-68.1519310491022, -16.4960277550434, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Natal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-35.2419501733195, -5.7780773155473, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Qingdao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.328063051587, 36.0919251260264, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gwangju'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.908488263201, 35.1729114541478, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Damascus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(36.2980500304171, 33.5019798542061, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Banghazi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(20.0647773252741, 32.1186792764011, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.99805328552031, 53.5519704955624, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Port Harcourt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.0134, 4.77742, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Semarang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(110.4203, -6.9932, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhangjiakou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.928030906383, 40.8319458779985, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manaus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-60.0019633977025, -3.09808586045858, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kaduna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.43805450621312, 10.5219613401167, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chittagong'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(91.7980215475663, 22.3319381468046, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mumbai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(72.88261, 19.07283, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kansas City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-94.6060400775458, 39.1090343683975, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gaziantep'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(37.3830484028173, 37.0769296019417, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibadan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.92803619565222, 7.38197212298183, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zürich'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.54806427184257, 47.3819336709934, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brussels'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.33137074969045, 50.8352629353303, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lusaka'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.2813817361143, -15.4146984093359, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dublin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.25085154039107, 53.3350069945849, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phoenix'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-112.07404, 33.44838, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciudad Juárez'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.48333, 31.73333, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xuzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.62227, 25.2692, 4326) ::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Düsseldorf'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.7799889715942, 51.2203735545832, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brisbane'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(153.033146873332, -27.4530850467537, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Miami'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.22605193945, 25.7895565550215, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(119.298100079577, 26.081941808929, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pune'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(73.8480577616872, 18.531963374654, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kharkiv'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(36.248078920391, 50.0019287881913, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Davao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(125.61278, 7.07306, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Florianopolis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-48.54917, -27.59667, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Port-au-Prince'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-72.3379804469055, 18.5429704547324, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ikare'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.7599995510173, 7.53043052055426, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kampala'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(32.581377667121, 0.318604813383331, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manila'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.980271303542, 14.6061048134405, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jiamusi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(130.31633, 46.79927, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-70.64827, -33.45694, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chicago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.65005, 41.85003, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Varanasi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(82.9980935690154, 25.3319359088608, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ho Chi Minh City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.62965, 10.82302, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lagos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.38958521259843, 6.44520751209319, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palembang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(104.7458, -2.91673, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dakar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-17.44406, 14.6937, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Seattle'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.33207, 47.60621, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhengzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.663146873175, 34.7569420124143, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Edmonton'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.501927794075, 53.5519704955624, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hanoi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(105.848068341242, 21.035273107737, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huainan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(116.978034975401, 32.631929601924, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jinan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(116.993072817198, 36.6769281777864, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanning'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(108.318098451929, 22.8219340777961, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benoni'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.32078, -26.18848, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guayaquil'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.9219878118445, -2.21808789496015, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sevilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.98000736634742, 37.4050152781609, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bekasi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.97232295637, -6.21725746778185, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Can Tho'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(105.770019082667, 10.0499924915931, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cincinnati'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-84.4588685084773, 39.1638306436168, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nagpur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(79.0880479960831, 21.1719055947166, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Buffalo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-78.8819479355382, 42.8819241088008, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hefei'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.278068341288, 31.8519772093429, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Porto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.62194712145526, 41.151952184966, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Srinagar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(74.8130634583055, 34.1019173948987, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marseille'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.37306427182989, 43.2919249226045, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(98.6480943828801, 3.58191983618275, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casablanca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.61831329169871, 33.6019220742585, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Urumqi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(87.5730597962472, 43.8069580850418, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Essen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.01661535505889, 51.4499977814723, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.00597, 40.71427, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dongguan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.742776341387, 23.050834758613, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almaty'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(76.92848, 43.25654, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhangzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.670016234408, 24.5203753855312, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jaipur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(75.8080414856534, 26.9230790973437, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bridgeport'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-73.2019070419611, 41.1819245156953, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paris'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.33138946713035, 48.8686387898146, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xian'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(108.92861, 34.25833, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.3661280299533, 23.1339046995422, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Salvador'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-89.18718, 13.68935, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kinshasa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.3130260231717, -4.32777824327598, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tunis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.179678099212, 36.8027781362314, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Porto Alegre'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-51.23, -30.03306, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kolkata'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(88.36304, 22.56263, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Austin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.7447242214211, 30.2688955442974, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Shanghai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.43455881982, 31.2183983112283, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Shangqiu'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(115.648090313938, 34.4523611204859, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moscow'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(37.6135769672714, 55.7541099812481, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Shangrao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.969997923862, 28.4703926788413, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perth'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(115.838052879043, -31.9530687707302, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Douala'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.70804514749829, 4.06235562720019, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lahore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(74.3480789205434, 31.5619173948884, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taian'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.29778, 36.75639, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haora'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(88.329946654212, 22.5803904408619, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ahmedabad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(72.5780577616821, 23.0319987750627, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novosibirsk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(82.9580960104215, 55.0319060017533, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bhilai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(81.4313874413872, 21.218612558613, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taichung'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.681667032, 24.1520774526, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wuxi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.298039044425, 31.5819420124014, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asansol'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(87.27475, 24.22966, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vijayawada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(80.6280573548131, 16.521905187797, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barranquilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.8019127385819, 10.9619344846499, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leshan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(103.76386, 29.56227, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Atlanta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-84.38798, 33.749, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['West Palm Beach'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.05337, 26.71534, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Delhi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(77.2280581686018, 28.6719387571815, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanjing'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.778028464992, 32.0519650023123, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yaounde'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5147048968544, 3.86864652075411, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Belgrade'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(20.4660448220205, 44.8205913044467, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ningbo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.548091941565, 29.8819165810796, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lyon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.82808461687983, 45.7719544229401, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['São Luís'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-44.30278, -2.52972, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Belo Horizonte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-43.9169503768048, -19.9130801639112, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Antananarivo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(47.5146780415298, -18.9146914920321, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Johannesburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.04363, -26.20227, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Da Nang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(108.22083, 16.06778, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baghdad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(44.3919229145641, 33.3405943561586, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mianyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(104.768030906342, 31.4719228880521, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dalian'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.627884979006, 38.9247842518157, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sofia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(23.3147081521101, 42.6852952839305, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dnipropetrovsk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(34.98333, 48.45, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexico City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.1329340602938, 19.4443883014155, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-70.6689867131748, -33.4480679569341, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fortaleza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-38.54306, -3.71722, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Auckland'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(174.763034975632, -36.8480671431456, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kumasi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.63196034571121, 6.69193672258848, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monterrey'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.33193064233, 25.6719409951253, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xinyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.068031720182, 32.1323218545261, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yulin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(110.148064272249, 22.631919836259, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rabat'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.83640815612614, 34.0253073110728, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kanpur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(80.30899, 28.7404, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rangoon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(96.1647317526618, 16.7852999631888, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xianyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(108.712776341387, 34.347501458613, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Changde'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(111.678100079547, 29.0319426227428, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Indianapolis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.1719939153852, 39.7519342813145, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Detroit'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-83.0820016464926, 42.3319060017023, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bucharest'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(26.0980007953504, 44.4353176634946, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mandalay'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(96.0830829896408, 21.9719342812433, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Minneapolis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-93.2537321966635, 44.9819251260619, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coimbatore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(76.9480752584443, 11.0019062050276, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aurangabad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(75.34226, 19.87757, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Warsaw'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(20.9980536924653, 52.2519464883955, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(35.3180581684341, 36.9969344847541, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tel Aviv'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(34.78057, 32.08088, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Angeles'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-118.24368, 34.05223, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yantai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.44081, 37.47649, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pretoria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.18783, -25.74486, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jinhua'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(119.649998737671, 29.1200429473984, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ranchi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(85.3280805481915, 23.3719521848948, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valencia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-68.00765, 10.16202, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maracaibo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.64056, 10.63167, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adelaide'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(138.598058982649, -34.9330419152734, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calgary'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-114.08529, 51.05011, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rome'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.481312562874, 41.8979014850989, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yiyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.328086244914, 28.6023564411006, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taiyuan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.54311187968, 37.8769582884684, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Handan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.478032533985, 36.5819210570179, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cagayan de Oro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(124.64722, 8.48222, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tainan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.200042683, 23.0000030711, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dallas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.80667, 32.78306, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asunción'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-57.63591, -25.30066, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Allahabad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(81.8380610169274, 25.4569411985749, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mosul'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(43.1430585753664, 36.3469483193867, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algiers'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.04860667090924, 36.7650106566281, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yerevan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(44.5116055317521, 40.1830965941419, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medellín'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.56359, 6.25184, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bucaramanga'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-73.1278288762705, 7.13203905820228, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phnom Penh'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(104.914688621186, 11.5519759885584, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jakarta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(106.84513, -6.21462, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.2019831325557, 19.0519057981587, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kobe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(135.169981647889, 34.6799878123297, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quito'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-78.52495, -0.22985, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tabriz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(46.2993000304572, 38.0882373818939, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Beirut'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(35.5077623513777, 33.8739209756269, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quanzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.578040672022, 24.9019621539765, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Doha'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(51.5329678942993, 25.2865560089066, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amman'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(35.9313540668741, 31.9519711058274, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jabalpur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(79.9531114726491, 23.1770028440736, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tampa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.4605667099667, 27.9489337929859, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Berlin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.3996027647005, 52.5237645222511, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Weifang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(119.09816396304, 36.722351761771, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.51809194111325, 12.0019226845236, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Panamá'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.51973, 8.9936, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wuhan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.268071189583, 30.5819772093378, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Milwaukee'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.9219129420849, 43.0546009073042, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Changchun'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(125.338041485851, 43.8669544229325, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haifa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(34.9780789203857, 32.8223572549196, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sydney'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(151.20732, -33.86785, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jeddah'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(39.19797, 21.54238, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nizhny Novgorod'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(43.9981485005, 56.334953080209, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jilin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.548096824398, 43.8519165811354, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Abidjan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.01266, 5.30966, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stuttgart'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.19999629582275, 48.7799798778156, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Prague'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.42076, 50.08804, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taipei'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.53185, 25.04776, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['København'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.5615398887033, 55.6805100490259, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Daegu'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(128.605025535344, 35.8687346149577, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baoding'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(115.478074851697, 38.8723755654906, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sholapur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(75.8980618307057, 17.6723517616949, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bangalore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(77.59369, 12.97194, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cilacap'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(109.015402383462, -7.7188195608868, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manchester'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.24993296127349, 53.5023611205623, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mashhad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(59.56796, 36.31559, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Antonio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.49363, 29.42412, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Daqing'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(124.998062237803, 46.5819049844668, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aden'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(45.0094901110702, 12.7797225127629, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['The Hague'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.26996130231345, 52.0800368439749, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhuhai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.565831941387, 22.2788902586129, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sendai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(140.8667, 38.25759, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boston'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.05977, 42.35843, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Helsinki'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(24.9321804828456, 60.177509232568, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aleppo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(37.16117, 36.20124, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhuzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.148087872522, 27.8319383502771, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Busan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(129.04028, 35.10278, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Makkah'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(39.8180935688427, 21.4319672402254, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bhopal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(77.4080471822743, 23.2519336708967, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orlando'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-81.3819762151707, 28.5119226845899, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Memphis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.04898, 35.14953, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xiamen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.08187, 24.47979, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Washington, D.C.'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-77.0113644394371, 38.901495235087, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quezon City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(121.029966185593, 14.6504351999447, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bangkok'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(100.514698793695, 13.751945064088, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Singapore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(103.853874819099, 1.29497932510594, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baltimore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.6219308456855, 39.3019359089167, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oakland'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.2708, 37.80437, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vishakhapatnam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(83.20161, 17.68009, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort Worth'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.32085, 32.72541, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-46.3348885150959, -23.9517780748547, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Changsha'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.968047182416, 28.2019157672708, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Datong'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(113.298052879032, 40.0819658161465, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tehran'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(56.29395, 35.31737, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bamako'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.00198496324969, 12.6519605263232, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Luoyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.468129376425, 34.6819336709425, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Seoul'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(126.997785138202, 37.5682949583889, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cleveland'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-81.69541, 41.4995, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portland'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.681935932133, 45.521969681728, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dar es Salaam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(39.2663959776946, -6.79806673612438, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Warangal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(79.5799897856874, 18.0099975778879, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Munich'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5730475889121, 48.1318878946292, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zibo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.048047182437, 36.8019334675005, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tangshan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.19243113426, 39.6262830361969, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lanzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(103.83987, 36.05701, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tianshui'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(105.74238, 34.57952, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ludhiana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(75.8703115865651, 30.9297079222298, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tijuana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.00371, 32.5027, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Luanda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.2324811826685, -8.83634025501265, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Accra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.218661598960693, 5.55198046444593, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hechi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(108.04985, 24.69834, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chennai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(80.2780528789003, 13.0919336708563, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Faridabad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(77.3147208413872, 28.4352791586129, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Florence'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.2500003648413, 43.7800008331993, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Surabaya'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.748887433067, -7.24728996203748, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ankang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(109.020001585936, 32.6799806915534, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santo Domingo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-69.98857, 18.50012, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caracas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-66.87919, 10.48801, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maracay'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-67.5977529892041, 10.248825557238, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zhanjiang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(110.34271, 21.28145, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.39182, 20.66682, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zaozhuang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.56807647931, 34.8819473021284, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tianjin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(117.1980732241, 39.1319721231089, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stockholm'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(18.0953888741809, 59.3527058128658, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bandung'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(107.61861, -6.90389, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Suzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.59538, 31.30408, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denver'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-104.985961810968, 39.7411339069655, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pittsburgh'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.0019312526002, 40.4319444538431, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hohhot'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(111.658049623818, 40.8219206501338, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kabul'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(69.181314190705, 34.5186361449003, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Norfolk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.2800057390244, 36.8499587189139, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['London'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.118667702475932, 51.5019405883275, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lisbon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-9.14681216410213, 38.7246687364878, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kuwait'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(47.9763552876253, 29.3716634886296, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kawasaki'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(139.705001992959, 35.5299876088826, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baku'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(49.89201, 40.37767, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort Lauderdale'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.141785524196, 26.1360648793528, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wenzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.66682, 27.99942, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madurai'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(78.1180813619646, 9.92197212299208, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Linyi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(118.328030092594, 35.0819350950979, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Melbourne'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(144.973070375904, -37.8180854536963, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heze'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(115.448102520968, 35.2319259398251, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tripoli'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.1800117580782, 32.8925000193537, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['George Town'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(100.32936786728, 5.41361315558424, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Francisco'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.417168773552, 37.7691956296874, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Qinhuangdao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(119.618080548329, 39.9323108682291, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ulsan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(129.315008038602, 35.548676631558, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Xining'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(101.768058982502, 36.621944453828, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Osaka'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(137.26667, 35.95, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nairobi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(36.8147110004714, -1.28140088323778, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Beijing'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(116.386339825659, 39.930838089909, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vancouver'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-123.123590076394, 49.2753624427117, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cologne'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.9418, 45.57862, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tokyo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(139.69171, 35.6895, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kazan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(49.12214, 55.78874, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['São Paulo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-46.63611, -23.5475, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sacramento'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-121.471983946451, 38.5769672402941, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Columbus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.991955463224, 39.9819202432293, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bogotá'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.08175, 4.60971, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chengdu'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(104.068073630949, 30.6719458779578, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cali'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.5225, 3.43722, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amritsar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(74.8680471822641, 31.6419383502926, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lubumbashi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(27.4780715961371, -11.6780789431752, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dhanbad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(86.4180398580916, 23.8023393512376, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hims'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(36.7180760720856, 34.7319047809689, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ankara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(32.8624457823566, 39.9291844440755, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madrid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.68529754461252, 40.4019721231138, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Katowice'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(19.0200170478151, 50.2603804718972, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cairo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(31.2480223611261, 30.0519062051037, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yekaterinburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(60.5980138163217, 56.8519757852891, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chelyabinsk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(61.4367223124188, 55.1569371296833, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rotterdam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.47802846453459, 51.9219149535637, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanyang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(112.528074037884, 33.0023462685923, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Qiqihar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(123.988046368658, 47.3469228881156, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Multan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(71.453061830688, 30.2019228880472, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saint Petersburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(30.31413, 59.93863, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cochabamba'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-66.16997684901, -17.4100109671756, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Athens'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(23.7313752256794, 37.9852720905522, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haikou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(110.320025593102, 20.0500022572581, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Samara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(50.1493492654986, 53.1969534057173, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brazzaville'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.2827436338487, -4.25723991319751, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Virginia Beach'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.9802645859174, 36.8551601927613, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kuala Lumpur'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(101.68653, 3.1412, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medina'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(39.61417, 24.46861, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alexandria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(29.9480500303917, 31.2019652057594, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Faisalabad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(73.1080512512675, 31.4119265501612, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mbuji-Mayi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(23.5980500303664, -6.1480805707572, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Newcastle'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(29.9318, -27.75796, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.098051251456, 30.8723212441696, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lille'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.07806223731552, 50.6519149535585, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dushanbe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(68.7738793527017, 38.5600352163166, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Daejeon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(127.423082175964, 36.3374915322773, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leeds'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.54785, 53.79648, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vienna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.3646930967437, 48.2019611368168, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Harare'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(31.0427635720628, -17.8158438357778, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Duisburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.75001664086505, 51.4299731639591, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucknow'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(80.9130528789029, 26.8569849404424, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mannheim'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47001501326769, 49.5003751821806, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitória'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-40.33778, -20.31944, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Changzhou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(119.968033347809, 31.7819298053712, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San José'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-84.08333, 9.93333, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Omsk'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(73.3980077128572, 54.9919342813753, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benin City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.61806223732571, 6.34242317278233, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jining'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(116.58139, 35.405, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rosario'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-60.6682534774577, -32.9491836795884, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Curitiba'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-49.27306, -25.42778, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Neijiang'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(105.048065492932, 29.5823224648676, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Turin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.66801462991208, 45.0723330443565, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hong Kong'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.15769, 22.28552, 4326) ::geography,3000)::geometry, 4326))" should true


}

function test_geocoding_functions_namedplace_germany() {
    # Germany tests - 2km of tolerance for the city point without country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kassel'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.5, 51.31667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bielefeld'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.53333, 52.03333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erfurt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.03283, 50.9787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Frankfurt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.53333, 49.68333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Berlin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.41053, 52.52437, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Osnabrück'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.0498, 52.27264, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Freiburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.85222, 47.9959, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Munich'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.57549, 48.13743, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bochum'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.21648, 51.48165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Regensburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11923, 49.03451, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salzgitter'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.33144, 52.15256, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saarbrücken'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98165, 49.2354, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dortmund'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.466, 51.51494, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heilbronn'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22054, 49.13995, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Remscheid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.1925, 51.17983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Düsseldorf'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.77616, 51.22172, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gelsenkirchen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.12283, 51.5075, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ulm'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.99155, 48.39841, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leipzig'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.37129, 51.33962, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trier'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.63935, 49.75565, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamm'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.82089, 51.68033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heidelberg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69079, 49.40768, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Magdeburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.62916, 52.12773, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Herne'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.22572, 51.5388, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergisch Gladbach'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.13298, 50.9856, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lübeck'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.68729, 53.86893, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Recklinghausen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.19738, 51.61379, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Koblenz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57883, 50.35357, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wolfsburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.7815, 52.42452, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ingolstadt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.42372, 48.76508, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kiel'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.13489, 54.32133, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Braunschweig'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.52673, 52.26594, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stuttgart'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.17702, 48.78232, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Karlsruhe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.40444, 49.00937, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Darmstadt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.65027, 49.87167, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Essen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.01228, 51.45657, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mönchengladbach'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.44172, 51.18539, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Augsburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.89851, 48.37154, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bottrop'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.9285, 51.52392, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fürth'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98856, 49.47593, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moers'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.6326, 51.45342, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hagen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.47168, 51.36081, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremerhaven'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.57673, 53.55021, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aachen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.08342, 50.77664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wiesbaden'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.24932, 50.08258, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oberhausen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88074, 51.47311, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.80777, 53.07516, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mannheim'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47955, 49.49671, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paderborn'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.75439, 51.71905, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Duisburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.76516, 51.43247, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Krefeld'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.58615, 51.33921, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siegen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.02431, 50.87481, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chemnitz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.92922, 50.8357, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Münster'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.62571, 51.96236, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dresden'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.73832, 51.05089, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.01534, 53.57532, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mainz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.2791, 49.98419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Neuss'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.68504, 51.19807, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reutlingen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.20427, 48.49144, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Würzburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95121, 49.79391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leverkusen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98432, 51.0303, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rostock'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.14049, 54.0887, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Solingen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.0845, 51.17343, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pforzheim'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69892, 48.88436, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bonn'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.09549, 50.73438, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oldenburg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.21467, 53.14118, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wuppertal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.16755, 51.27027, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potsdam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.06566, 52.39886, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nürnberg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.07752, 49.45421, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Köln'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.95, 50.93333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mülheim an der Ruhr'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88333, 51.43333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hannover'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.73322, 52.37052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ludwigshafen am Rhein'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.44641, 49.48121, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cottbus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.32888, 51.75769, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erlangen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.00783, 49.59099, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hildesheim'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95112, 52.15077, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5899, 50.92878, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Göttingen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.93228, 51.53443, 4326)::geography,3000)::geometry, 4326))" should true
  
    # Germany tests - 2km of tolerance for the city point with country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kassel'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.5, 51.31667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bielefeld'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.53333, 52.03333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erfurt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.03283, 50.9787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Frankfurt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.53333, 49.68333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Berlin'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.41053, 52.52437, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Osnabrück'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.0498, 52.27264, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Freiburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.85222, 47.9959, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Munich'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.57549, 48.13743, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bochum'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.21648, 51.48165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Regensburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11923, 49.03451, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salzgitter'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.33144, 52.15256, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saarbrücken'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98165, 49.2354, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dortmund'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.466, 51.51494, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heilbronn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22054, 49.13995, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Remscheid'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.1925, 51.17983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Düsseldorf'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.77616, 51.22172, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gelsenkirchen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.12283, 51.5075, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Halle'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.36083, 52.06007, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ulm'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.99155, 48.39841, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leipzig'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.37129, 51.33962, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trier'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.63935, 49.75565, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamm'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.82089, 51.68033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heidelberg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69079, 49.40768, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Magdeburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.62916, 52.12773, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Herne'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.22572, 51.5388, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergisch Gladbach'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.13298, 50.9856, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lübeck'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.68729, 53.86893, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Recklinghausen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.19738, 51.61379, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Koblenz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57883, 50.35357, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wolfsburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.7815, 52.42452, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ingolstadt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.42372, 48.76508, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kiel'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.13489, 54.32133, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Braunschweig'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.52673, 52.26594, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stuttgart'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.17702, 48.78232, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Karlsruhe'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.40444, 49.00937, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Darmstadt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.65027, 49.87167, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Essen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.01228, 51.45657, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mönchengladbach'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.44172, 51.18539, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Augsburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.89851, 48.37154, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bottrop'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.9285, 51.52392, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fürth'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98856, 49.47593, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moers'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.6326, 51.45342, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hagen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.47168, 51.36081, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremerhaven'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.57673, 53.55021, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aachen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.08342, 50.77664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wiesbaden'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.24932, 50.08258, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oberhausen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88074, 51.47311, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.80777, 53.07516, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mannheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47955, 49.49671, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paderborn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.75439, 51.71905, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Duisburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.76516, 51.43247, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Krefeld'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.58615, 51.33921, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siegen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.02431, 50.87481, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chemnitz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.92922, 50.8357, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Münster'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.62571, 51.96236, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dresden'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.73832, 51.05089, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.01534, 53.57532, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mainz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.2791, 49.98419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Neuss'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.68504, 51.19807, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reutlingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.20427, 48.49144, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Würzburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95121, 49.79391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leverkusen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98432, 51.0303, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rostock'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.14049, 54.0887, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Solingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.0845, 51.17343, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pforzheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69892, 48.88436, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bonn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.09549, 50.73438, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oldenburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.21467, 53.14118, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wuppertal'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.16755, 51.27027, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potsdam'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.06566, 52.39886, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nuremberg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.07752, 49.45421, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cologne'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.95, 50.93333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mülheim an der Ruhr'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88333, 51.43333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hanover'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.73322, 52.37052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ludwigshafen am Rhein'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.44641, 49.48121, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cottbus'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.32888, 51.75769, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erlangen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.00783, 49.59099, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hildesheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95112, 52.15077, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jena'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5899, 50.92878, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Göttingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.93228, 51.53443, 4326)::geography,3000)::geometry, 4326))" should true
}

function test_geocoding_functions_namedplace_italy() {

    # Italy tests - 2km of tolerance for the city point without country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pescara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20283, 42.4584, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acerra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.37261, 40.94744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acireale'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.16325, 37.62606, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Afragola'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.31323, 40.9242, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agrigento'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.59351, 37.32744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alessandria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.61007, 44.90924, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altamura'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.54952, 40.82664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ancona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.50337, 43.5942, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.29797, 41.23117, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Anzio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.61883, 41.48493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aprilia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.65729, 41.58808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arezzo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.86867, 43.44708, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ascoli Piceno'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.60658, 42.85185, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asti'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.20751, 44.90162, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avellino'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79652, 40.92033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aversa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20745, 40.97259, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bagheria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.51237, 38.07892, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bari'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.8554, 41.11148, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barletta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.28165, 41.31429, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Battipaglia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.9876, 40.6045, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.3259, 43.32215, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benevento'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.78101, 41.1256, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergamo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.66721, 45.69601, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bisceglie'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.49492, 41.24106, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bitonto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.69086, 41.11006, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bologna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33875, 44.49381, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bolzano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33982, 46.49067, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brescia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.21472, 45.53558, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brindisi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.93607, 40.63215, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Busto Arsizio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.84914, 45.61128, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caltanissetta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.05163, 37.48997, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Campobasso'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.66737, 41.55947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carpi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.39472, 45.1356, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carrara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.06049, 44.05405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casalnuovo di Napoli'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34993, 40.90834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caserta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34002, 41.07619, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cava de'' Tirreni'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70564, 40.70091, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['L’Aquila'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.39954, 42.35055, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casoria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.29363, 40.90906, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellammare di Stabia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.48685, 40.70211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catania'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.07041, 37.49223, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catanzaro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.60086, 38.88247, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cerignola'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.8998, 41.26383, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cesena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.24315, 44.1391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chieti'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.16163, 42.35296, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chioggia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.27774, 45.21857, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cinisello Balsamo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22104, 45.55646, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Civitavecchia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79674, 42.09325, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Collegno'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57832, 45.07919, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Como'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.08065, 45.80079, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cosenza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.25201, 39.30422, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cremona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.02297, 45.14047, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crotone'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.10997, 39.0823, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuneo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.54828, 44.39071, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ercolano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.36382, 40.8138, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Faenza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.88334, 44.2857, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.01665, 43.84052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.60868, 44.84346, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fiumicino'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.68488, 45.89938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Florence'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.24626, 43.77925, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foggia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55188, 41.45845, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foligno'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.70664, 42.95324, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Forlì'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.05245, 44.22054, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gallarate'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.79164, 45.66019, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gela'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.23704, 37.0757, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Genoa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91519, 44.4264, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Giugliano in Campania'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.19557, 40.93188, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Grosseto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.10955, 42.76871, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guidonia Montecelio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.72238, 41.99362, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Imola'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.7132, 44.35916, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lamezia Terme'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.3092, 38.96589, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Spezia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.83632, 44.11096, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lecce'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(18.17244, 40.35481, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Legnano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91355, 45.5947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Livorno'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32615, 43.54427, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.47234, 43.8497, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manfredonia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.91038, 41.62746, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marano di Napoli'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.17476, 40.89601, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marsala'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.4983, 37.86736, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Massa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.11869, 44.02079, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Matera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59723, 40.66983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazara del Vallo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.59304, 37.65418, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Messina'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55256, 38.19394, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92539, 44.64783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modica'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.76976, 36.8499, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Molfetta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59503, 41.19695, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncalieri'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.69202, 45.0031, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.27246, 45.58005, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.62328, 45.44834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olbia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.50395, 40.92334, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palermo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.33561, 38.13205, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parma'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32618, 44.79935, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pavia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.15917, 45.19205, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perugia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.38878, 43.1122, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pesaro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.895, 43.90121, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Piacenza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.70462, 45.04202, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pisa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.4036, 43.70853, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pistoia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92365, 43.93064, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pomezia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.50015, 41.66369, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pordenone'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.66051, 45.95689, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portici'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.33716, 40.81563, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potenza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.80794, 40.64175, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozzuoli'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.15321, 40.82767, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Prato'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.08278, 43.87309, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quartu Sant''Elena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.25004, 39.22935, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ragusa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70689, 36.89639, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ravenna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.20121, 44.41344, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Calabria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.66129, 38.11047, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rho'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.05182, 45.52812, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rimini'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.56528, 44.05755, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rome'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.51133, 41.89193, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rovigo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79109, 45.07387, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salerno'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79328, 40.67545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Severo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.38148, 41.68564, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sassari'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.55037, 40.72787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Savona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47715, 44.30905, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scafati'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52919, 40.75766, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scandicci'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.18794, 43.75423, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sesto San Giovanni'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.23401, 45.53449, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taranto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.25478, 40.41639, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teramo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.69901, 42.66123, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Terni'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.63667, 42.56184, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tivoli'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.80317, 41.95781, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torre del Greco'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.39782, 40.77939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trani'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.41011, 41.27733, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trapani'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.54127, 38.01391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trento'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.12108, 46.06787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Treviso'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.23614, 45.66908, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trieste'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.7903, 45.64325, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Turin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.68682, 45.07049, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Udine'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.24458, 46.0637, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Varese'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.82223, 45.81934, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Velletri'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.78103, 41.66784, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Venice'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.33265, 45.43713, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Verona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98444, 45.4299, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viareggio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.25581, 43.87145, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vicenza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5475, 45.54672, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigevano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.85437, 45.31407, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viterbo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11141, 42.42322, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vittoria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52788, 36.95151, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Emilia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.63125, 44.69825, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanremo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.7772, 43.81725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cagliari'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.11917, 39.23054, 4326)::geography,3000)::geometry, 4326))" should true

    # Italy tests - 2km of tolerance for the city point with country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pescara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20283, 42.4584, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acerra'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.37261, 40.94744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acireale'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.16325, 37.62606, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Afragola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.31323, 40.9242, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agrigento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.59351, 37.32744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alessandria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.61007, 44.90924, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altamura'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.54952, 40.82664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ancona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.50337, 43.5942, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.29797, 41.23117, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Anzio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.61883, 41.48493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aprilia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.65729, 41.58808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arezzo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.86867, 43.44708, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ascoli Piceno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.60658, 42.85185, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asti'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.20751, 44.90162, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avellino'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79652, 40.92033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aversa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20745, 40.97259, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bagheria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.51237, 38.07892, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.8554, 41.11148, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barletta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.28165, 41.31429, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Battipaglia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.9876, 40.6045, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.3259, 43.32215, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benevento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.78101, 41.1256, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergamo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.66721, 45.69601, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bisceglie'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.49492, 41.24106, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bitonto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.69086, 41.11006, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bologna'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33875, 44.49381, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bolzano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33982, 46.49067, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brescia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.21472, 45.53558, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brindisi'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.93607, 40.63215, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Busto Arsizio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.84914, 45.61128, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caltanissetta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.05163, 37.48997, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Campobasso'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.66737, 41.55947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carpi'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.39472, 45.1356, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carrara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.06049, 44.05405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casalnuovo di Napoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34993, 40.90834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caserta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34002, 41.07619, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cava de'' Tirreni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70564, 40.70091, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['L’Aquila'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.39954, 42.35055, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casoria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.29363, 40.90906, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellammare di Stabia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.48685, 40.70211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catania'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.07041, 37.49223, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catanzaro'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.60086, 38.88247, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cerignola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.8998, 41.26383, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cesena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.24315, 44.1391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chieti'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.16163, 42.35296, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chioggia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.27774, 45.21857, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cinisello Balsamo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22104, 45.55646, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Civitavecchia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79674, 42.09325, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Collegno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57832, 45.07919, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Como'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.08065, 45.80079, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cosenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.25201, 39.30422, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cremona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.02297, 45.14047, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crotone'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.10997, 39.0823, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuneo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.54828, 44.39071, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ercolano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.36382, 40.8138, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Faenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.88334, 44.2857, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.01665, 43.84052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.60868, 44.84346, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fiumicino'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.68488, 45.89938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Florence'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.24626, 43.77925, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foggia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55188, 41.45845, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foligno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.70664, 42.95324, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Forlì'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.05245, 44.22054, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gallarate'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.79164, 45.66019, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gela'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.23704, 37.0757, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Genoa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91519, 44.4264, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Giugliano in Campania'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.19557, 40.93188, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Grosseto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.10955, 42.76871, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guidonia Montecelio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.72238, 41.99362, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Imola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.7132, 44.35916, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lamezia Terme'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.3092, 38.96589, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Spezia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.83632, 44.11096, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Latina'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.9043, 41.46614, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lecce'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(18.17244, 40.35481, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Legnano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91355, 45.5947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Livorno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32615, 43.54427, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucca'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.47234, 43.8497, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manfredonia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.91038, 41.62746, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marano di Napoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.17476, 40.89601, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marsala'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.4983, 37.86736, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Massa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.11869, 44.02079, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Matera'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59723, 40.66983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazara del Vallo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.59304, 37.65418, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Messina'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55256, 38.19394, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Milan'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.17278, 45.59282, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92539, 44.64783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modica'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.76976, 36.8499, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Molfetta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59503, 41.19695, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncalieri'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.69202, 45.0031, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.27246, 45.58005, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.62328, 45.44834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olbia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.50395, 40.92334, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palermo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.33561, 38.13205, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parma'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32618, 44.79935, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pavia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.15917, 45.19205, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perugia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.38878, 43.1122, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pesaro'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.895, 43.90121, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Piacenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.70462, 45.04202, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pisa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.4036, 43.70853, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pistoia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92365, 43.93064, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pomezia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.50015, 41.66369, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pordenone'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.66051, 45.95689, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portici'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.33716, 40.81563, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.80794, 40.64175, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozzuoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.15321, 40.82767, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Prato'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.08278, 43.87309, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quartu Sant''Elena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.25004, 39.22935, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ragusa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70689, 36.89639, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ravenna'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.20121, 44.41344, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Calabria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.66129, 38.11047, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rho'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.05182, 45.52812, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rimini'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.56528, 44.05755, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rome'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.51133, 41.89193, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rovigo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79109, 45.07387, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salerno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79328, 40.67545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Severo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.38148, 41.68564, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sassari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.55037, 40.72787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Savona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47715, 44.30905, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scafati'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52919, 40.75766, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scandicci'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.18794, 43.75423, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sesto San Giovanni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.23401, 45.53449, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taranto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.25478, 40.41639, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teramo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.69901, 42.66123, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Terni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.63667, 42.56184, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tivoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.80317, 41.95781, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torre del Greco'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.39782, 40.77939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trani'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.41011, 41.27733, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trapani'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.54127, 38.01391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.12108, 46.06787, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Treviso'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.23614, 45.66908, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trieste'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.7903, 45.64325, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Turin'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.68682, 45.07049, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Udine'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.24458, 46.0637, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Varese'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.82223, 45.81934, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Velletri'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.78103, 41.66784, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Venice'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.33265, 45.43713, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Verona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98444, 45.4299, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viareggio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.25581, 43.87145, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vicenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5475, 45.54672, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigevano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.85437, 45.31407, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viterbo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11141, 42.42322, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vittoria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52788, 36.95151, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Naples'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.24641, 40.85631, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Padua'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.88586, 45.40797, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Emilia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.63125, 44.69825, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanremo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.7772, 43.81725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Syracuse'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.27628, 37.08415, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cagliari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.11917, 39.23054, 4326)::geography,3000)::geometry, 4326))" should true
}

function test_geocoding_functions_namedplace_spain() {

    # Spain tests - 2km of tolerance for the city point with no country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Palmas de Gran Canaria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41343, 28.09973, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Riveira'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.33333, 42.85, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Feliú de Llobregat'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.05, 41.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro de Ribas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.76667, 41.26667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Eulalia del Río'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.53409, 38.98457, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Lucía de Tirajana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.54071, 27.91174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Perpetua de Moguda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.18333, 41.53333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Vicente del Raspeig'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5255, 38.3964, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vendrell'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.53333, 41.21667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villafranca del Panadés'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.7, 41.35, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vinaroz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.47559, 40.47033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zarauz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.16992, 43.28444, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá la Real'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92301, 37.4614, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcantarilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.21714, 37.96939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcázar de San Juan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.20827, 39.39011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcobendas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.64197, 40.54746, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcorcón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.82487, 40.34582, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcoy'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.47432, 38.70545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alfafar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.38333, 39.41667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algeciras'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.45051, 36.13326, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algemesí'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43572, 39.19042, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algete'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.49743, 40.59711, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhama de Murcia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.42507, 37.85103, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhaurín de la Torre'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56139, 36.66401, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhaurín el Grande'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.68728, 36.643, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alicante'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.48149, 38.34517, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almansa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.09713, 38.86917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almendralejo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.40747, 38.68316, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almería'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45974, 36.83814, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almonte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.51667, 37.2647, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almuñécar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69072, 36.73393, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altea'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.05139, 38.59885, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amposta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.58103, 40.71308, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andújar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.05077, 38.03922, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Antequera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56123, 37.01938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranda de Duero'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.6892, 41.67041, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranjuez'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60246, 40.03108, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arcos de la Frontera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.81056, 36.75075, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Armilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.61854, 37.14102, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.68102, 28.09962, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arrecife'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.54769, 28.96302, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arucas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.52325, 28.11983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aspe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.76721, 38.34511, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ávila'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.69951, 40.65724, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avilés'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92483, 43.55473, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ayamonte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.40266, 37.20994, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Azuqueca de Henares'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.25992, 40.56688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badajoz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.97061, 38.87789, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badalona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.24741, 41.45004, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.32245, 37.6167, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barañáin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.67731, 42.80567, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barcelona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.15899, 41.38879, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Basauri'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.8858, 43.2397, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.77259, 37.49073, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benalmádena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56937, 36.59548, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benicarló'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.42709, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benidorm'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.13098, 38.53816, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bétera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45, 39.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bilbao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.92528, 43.26271, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blanes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79036, 41.67419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boadilla del Monte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87835, 40.405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burgos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67527, 42.35022, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burriana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08499, 39.88901, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cabra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.44206, 37.47249, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cáceres'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.37224, 39.47649, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calafell'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.5683, 41.19997, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calahorra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.96521, 42.30506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calatayud'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64318, 41.35353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Camargo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.88498, 43.40744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Camas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.03314, 37.40202, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambre'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.34736, 43.29438, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambrils'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.05244, 41.07479, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carballo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.69104, 43.213, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carcaixent'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44812, 39.1218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cártama'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63297, 36.71068, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castrillón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.79217, 43.39788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castro-Urdiales'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.22043, 43.38285, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catarroja'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4, 39.4, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ceuta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.31979, 35.88933, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chiclana de la Frontera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.14941, 36.41915, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciempozuelos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.62103, 40.15913, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cieza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.41987, 38.23998, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciudad Real'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92907, 38.98626, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coín'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.75639, 36.65947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colmenar Viejo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76762, 40.65909, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Conil de la Frontera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0885, 36.27719, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coria del Río'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0541, 37.28766, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coslada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.56129, 40.42378, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crevillente'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.80975, 38.24994, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cullera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Culleredo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.38858, 43.28788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.10574, 38.84078, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Don Benito'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.86162, 38.95627, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dos Hermanas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92088, 37.28287, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Durango'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.6338, 43.17124, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Écija'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.0826, 37.5422, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elche'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.70107, 38.26218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79157, 38.47783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Ejido'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.81456, 36.77629, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Masnou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3188, 41.47978, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Prat de Llobregat'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.09472, 41.32784, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Puerto de Santa María'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.23298, 36.59389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erandio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.94502, 43.30788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Estepona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.14589, 36.42764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrol'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.23689, 43.48321, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Figueras'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.02559, 43.53943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuengirola'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.62473, 36.53998, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuenlabrada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79415, 40.28419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galapagar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.00426, 40.5783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gáldar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.6502, 28.14701, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Getafe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.73295, 40.30571, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gijón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66152, 43.53573, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60667, 37.18817, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granadilla de Abona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.57599, 28.11882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granollers'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28773, 41.60797, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadix'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.13922, 37.29932, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guía de Isora'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.77947, 28.21154, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hellín'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.70096, 38.5106, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huelva'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.94004, 37.26638, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huesca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4087, 42.13615, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.57225, 38.62533, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibiza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.43296, 38.90883, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Icod de los Vinos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.71188, 28.37241, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Igualada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.6172, 41.58098, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Illescas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.84704, 40.12213, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Inca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.91093, 39.7211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ingenio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.4406, 27.92086, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Isla Cristina'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.31667, 37.2, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jaén'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79028, 37.76922, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jerez de la Frontera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.13606, 36.68645, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jumilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.325, 38.47917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Laguna de Duero'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72332, 41.58151, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lalín'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.11285, 42.66085, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Línea de la Concepción'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.34777, 36.16809, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Oliva'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.92912, 28.61052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Orotava'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.52309, 28.39076, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Rinconada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.98091, 37.48613, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Rozas de Madrid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87371, 40.49292, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Torres de Cotillas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.24188, 38.02822, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lebrija'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.07529, 36.92077, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leganés'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.7635, 40.32718, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lepe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.20433, 37.25482, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lloret de Mar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.84565, 41.69993, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Logroño'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45, 42.46667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lorca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.7017, 37.67119, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Barrios'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.49213, 36.18482, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Llanos de Aridane'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-17.91821, 28.65851, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Palacios y Villafranca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92433, 37.16181, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Realejos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.58335, 28.36739, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lugo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.55602, 43.00992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madrid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70256, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Alcor'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.74951, 37.37301, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Aljarafe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.06391, 37.34461, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Majadahonda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87182, 40.47353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Málaga'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.42034, 36.72016, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manacor'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.20955, 39.56964, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manises'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46349, 39.49139, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manlleu'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28476, 42.00228, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manresa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.82656, 41.72498, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maracena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.63493, 37.20764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marbella'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.88583, 36.51543, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marín'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.7, 42.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martorell'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.93062, 41.47402, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.97264, 37.72107, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mataró'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.4445, 41.54211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazarrón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.31493, 37.5992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medina del Campo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.91413, 41.31239, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mejorada del Campo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.48194, 40.39283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Melilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.93833, 35.29369, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mieres'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.76667, 43.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mijas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63728, 36.59575, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Miranda de Ebro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.94695, 42.6865, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mislata'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41825, 39.47523, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mogán'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.72538, 27.88385, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moguer'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.83851, 37.27559, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Molina de Segura'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.20763, 38.05456, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.39551, 39.54555, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63805, 37.58627, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Morón de la Frontera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.45403, 37.12084, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Móstoles'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.86496, 40.32234, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Motril'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.5179, 36.75066, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Muchamiel'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44529, 38.4158, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Murcia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.13004, 37.98704, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Narón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.19082, 43.50175, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Navalcarnero'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.01197, 40.28908, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nerja'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.8744, 36.75278, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Níjar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.20595, 36.96655, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novelda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.76773, 38.38479, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oleiros'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.31667, 43.33333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olesa de Montserrat'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.89407, 41.54372, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oliva'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11935, 38.91971, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olot'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.49012, 42.18096, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.96667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orihuela'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.94401, 38.08483, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oviedo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.84476, 43.36029, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paiporta'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41667, 39.43333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pájara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-14.1076, 28.35039, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palafrugell'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.1631, 41.91738, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palencia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.52406, 42.00955, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palma del Río'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.28121, 37.70024, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pamplona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64323, 42.81687, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paracuellos de Jarama'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.52775, 40.50353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76752, 40.23604, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paterna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43333, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pilar de la Horadada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79256, 37.86591, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pineda de Mar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.6889, 41.62763, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pinto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69999, 40.24147, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Plasencia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.08845, 40.03116, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ponferrada'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.59619, 42.54664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pontevedra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.64435, 42.431, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portugalete'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02064, 43.32099, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozuelo de Alarcón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.81338, 40.43293, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Priego de Córdoba'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.19523, 37.43807, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto de la Cruz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.54867, 28.41397, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto del Rosario'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.86272, 28.50038, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puertollano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10734, 38.68712, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto Real'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.19011, 36.52819, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Redondela'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.6096, 42.28337, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Requena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10044, 39.48834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.10687, 41.15612, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rincón de la Victoria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.27583, 36.71715, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ripollet'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.15739, 41.49686, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rojales'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.72544, 38.08799, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ronda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.16709, 36.74231, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Roquetas de Mar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.61475, 36.76419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rota'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3622, 36.62545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rubí'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.03305, 41.49226, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sabadell'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10942, 41.54329, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sagunto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.26667, 39.68333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salamanca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66388, 40.96882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salou'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.14163, 41.07663, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79281, 41.97489, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Andrés del Rabanedo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.61671, 42.61174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Antonio Abad'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.08, 16.89111, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Cristóbal de la Laguna'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.85896, 19.31629, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(120.6898, 15.0286, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando de Henares'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.53261, 40.42386, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Javier'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.83736, 37.80626, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San José'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-84.08333, 9.93333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Juan de Alicante'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43623, 38.40148, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Juan de Aznalfarache'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.03731, 37.35813, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanlúcar de Barrameda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3515, 36.77808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro del Pinatar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79102, 37.83568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Roque'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.38415, 36.21067, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Sebastián'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.65, 14.56667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Sebastián de los Reyes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.61588, 40.54433, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Cruz de Tenerife'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.25462, 28.46824, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santander'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.80444, 43.46472, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Pola'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5658, 38.19165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago de Compostela'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.54569, 42.88052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santurce'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-61.18135, -30.18985, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Segovia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.11839, 40.94808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sestao'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.00716, 43.30975, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sevilla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.97317, 37.38283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siero'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.4775, 43.08347, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sitges'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.81193, 41.23506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Soria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.46883, 41.76401, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sueca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.31114, 39.2026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tacoronte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.41016, 28.47688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Talavera de la Reina'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.83076, 39.96348, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tarragona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.25, 41.11667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teguise'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.56397, 29.06049, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Telde'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41915, 27.99243, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teruel'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10646, 40.3456, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tías'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.64502, 28.96108, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toledo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-83.55521, 41.66394, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomares'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.04589, 37.37281, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomelloso'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02156, 39.15759, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrejón de Ardoz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.46973, 40.45535, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelavega'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.04785, 43.34943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelodones'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92658, 40.57654, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torremolinos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.49976, 36.62035, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrente'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.65593, 9.3762, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrevieja'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.68222, 37.97872, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tortosa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.5216, 40.81249, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Totana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.50229, 37.7688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tres Cantos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70806, 40.60092, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tudela'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.60452, 42.06166, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Úbeda'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.3705, 38.01328, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Utrera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.78093, 37.18516, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdemoro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67887, 40.19081, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdepeñas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.38483, 38.76211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valencia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-68.00765, 10.16202, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valladolid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72372, 41.65518, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valls'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.24993, 41.28612, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vélez-Málaga'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10045, 36.77262, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vícar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.64273, 36.83155, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vich'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.31001, 46.15354, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.72264, 42.23282, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viladecans'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.01427, 41.31405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vilaseca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25528, 42.06174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villajoyosa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.23346, 38.50754, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villanueva de la Serena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.7974, 38.97655, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarreal'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-93.22361, 16.26361, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarrobledo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.60119, 39.26992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villaviciosa de Odón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.90011, 40.35692, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villena'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.86568, 38.6373, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitoria'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-36.3825, -5.24389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yecla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.11468, 38.61365, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zamora'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-102.28387, 19.9855, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zaragoza'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.87734, 41.65606, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alacuás'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.461, 39.45568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Guadaíra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.83951, 37.33791, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aldaya'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46005, 39.46569, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alfaz del Pi'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.10321, 38.58055, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almazora'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.06313, 39.94729, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barbate'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92186, 36.19237, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calviá'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.50621, 39.5657, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellón de la Plana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.03333, 39.98333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Collado Villalba'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.00486, 40.63506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuart de Poblet'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43937, 39.48139, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Éibar'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.47158, 43.18493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Esparraguera'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.87025, 41.53809, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galdácano'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.83333, 43.23333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gandía'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.18333, 38.96667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guecho'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.01146, 43.35689, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hospitalet de Llobregat'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10028, 41.35967, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Irún'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78938, 43.33904, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Játiva'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.51852, 38.99042, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jávea'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.16667, 38.78333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Coruña'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.396, 43.37135, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Langreo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.68416, 43.29568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lejona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.98333, 43.33333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mahón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.26583, 39.88853, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mollet del Vallés'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.21306, 41.54026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onteniente'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.60603, 38.82191, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Picasent'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45949, 39.3635, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla de Vallbona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.55468, 39.59747, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puente Genil'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.76686, 37.38943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Andrés de la Barca'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.97187, 41.44659, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adeje'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.726, 28.12271, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adra'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02055, 36.74961, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Águilas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.58289, 37.4063, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agüimes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.44609, 27.90539, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Albacete'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.85643, 38.99424, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alboraya'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.35, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Henares'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.35996, 40.48205, 4326)::geography,3000)::geometry, 4326))" should true

    # Spain tests - 2km of tolerance for the city point with country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Palmas de Gran Canaria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41343, 28.09973, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Riveira'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.33333, 42.85, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Feliú de Llobregat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.05, 41.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro de Ribas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.76667, 41.26667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Eulalia del Río'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.53409, 38.98457, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Lucía de Tirajana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.54071, 27.91174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Perpetua de Moguda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.18333, 41.53333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Vicente del Raspeig'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5255, 38.3964, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vendrell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.53333, 41.21667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villafranca del Panadés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.7, 41.35, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vinaroz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.47559, 40.47033, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zarauz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.16992, 43.28444, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá la Real'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92301, 37.4614, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcantarilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.21714, 37.96939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcázar de San Juan'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.20827, 39.39011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcira'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43333, 39.15, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcobendas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.64197, 40.54746, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcorcón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.82487, 40.34582, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcoy'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.47432, 38.70545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alfafar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.38333, 39.41667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algeciras'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.45051, 36.13326, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algemesí'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43572, 39.19042, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algete'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.49743, 40.59711, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhama de Murcia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.42507, 37.85103, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhaurín de la Torre'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56139, 36.66401, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alhaurín el Grande'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.68728, 36.643, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alicante'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.48149, 38.34517, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almansa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.09713, 38.86917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almendralejo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.40747, 38.68316, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almería'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45974, 36.83814, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almonte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.51667, 37.2647, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almuñécar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69072, 36.73393, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altea'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.05139, 38.59885, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amposta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.58103, 40.71308, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andújar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.05077, 38.03922, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Antequera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56123, 37.01938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranda de Duero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.6892, 41.67041, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranjuez'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60246, 40.03108, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arcos de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.81056, 36.75075, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Armilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.61854, 37.14102, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.68102, 28.09962, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arrecife'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.54769, 28.96302, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arucas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.52325, 28.11983, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aspe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.76721, 38.34511, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ávila'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.69951, 40.65724, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avilés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92483, 43.55473, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ayamonte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.40266, 37.20994, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Azuqueca de Henares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.25992, 40.56688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badajoz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.97061, 38.87789, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badalona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.24741, 41.45004, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.32245, 37.6167, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baracaldo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.99729, 43.29564, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barañáin'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.67731, 42.80567, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barcelona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.15899, 41.38879, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Basauri'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.8858, 43.2397, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.77259, 37.49073, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benalmádena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56937, 36.59548, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benicarló'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.42709, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benidorm'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.13098, 38.53816, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bétera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45, 39.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bilbao'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.92528, 43.26271, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blanes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79036, 41.67419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boadilla del Monte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87835, 40.405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burgos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67527, 42.35022, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burriana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08499, 39.88901, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cabra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.44206, 37.47249, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cáceres'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.37224, 39.47649, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cádiz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.29465, 36.52978, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calafell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.5683, 41.19997, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calahorra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.96521, 42.30506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calatayud'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64318, 41.35353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calpe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.0445, 38.6447, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Camargo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.88498, 43.40744, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Camas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.03314, 37.40202, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambre'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.34736, 43.29438, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambrils'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.05244, 41.07479, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Campello'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.09855, 40.51519, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Candelaria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.37268, 28.3548, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carballo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.69104, 43.213, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carcaixent'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44812, 39.1218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carmona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.64608, 37.47125, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cartagena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.98623, 37.60512, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cártama'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63297, 36.71068, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castrillón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.79217, 43.39788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castro-Urdiales'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.22043, 43.38285, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catarroja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4, 39.4, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ceuta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.31979, 35.88933, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chiclana de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.14941, 36.41915, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciempozuelos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.62103, 40.15913, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cieza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.41987, 38.23998, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciudadela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.84144, 40.00112, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciudad Real'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92907, 38.98626, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coín'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.75639, 36.65947, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colmenar Viejo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76762, 40.65909, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Conil de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0885, 36.27719, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Córdoba'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.77275, 37.89155, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coria del Río'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0541, 37.28766, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coslada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.56129, 40.42378, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crevillente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.80975, 38.24994, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuenca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.13333, 40.06667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cullera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Culleredo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.38858, 43.28788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.10574, 38.84078, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Don Benito'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.86162, 38.95627, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dos Hermanas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92088, 37.28287, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Durango'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.6338, 43.17124, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Écija'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.0826, 37.5422, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elche'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.70107, 38.26218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79157, 38.47783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Ejido'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.81456, 36.77629, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Masnou'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3188, 41.47978, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Prat de Llobregat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.09472, 41.32784, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Puerto de Santa María'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.23298, 36.59389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erandio'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.94502, 43.30788, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Estepona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.14589, 36.42764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrol'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.23689, 43.48321, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Figueras'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.02559, 43.53943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuengirola'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.62473, 36.53998, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuenlabrada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79415, 40.28419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galapagar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.00426, 40.5783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gáldar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.6502, 28.14701, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gerona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.82493, 41.98311, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Getafe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.73295, 40.30571, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gijón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66152, 43.53573, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60667, 37.18817, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granadilla de Abona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.57599, 28.11882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granollers'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28773, 41.60797, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.16185, 40.62862, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadix'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.13922, 37.29932, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guía de Isora'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.77947, 28.21154, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hellín'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.70096, 38.5106, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huelva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.94004, 37.26638, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huesca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4087, 42.13615, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibi'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.57225, 38.62533, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibiza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.43296, 38.90883, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Icod de los Vinos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.71188, 28.37241, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Igualada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.6172, 41.58098, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Illescas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.84704, 40.12213, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Inca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.91093, 39.7211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ingenio'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.4406, 27.92086, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Isla Cristina'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.31667, 37.2, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jaén'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79028, 37.76922, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jerez de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.13606, 36.68645, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jumilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.325, 38.47917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Estrada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.48842, 42.68911, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Laguna de Duero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72332, 41.58151, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lalín'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.11285, 42.66085, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Línea de la Concepción'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.34777, 36.16809, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Oliva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.92912, 28.61052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Orotava'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.52309, 28.39076, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Rinconada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.98091, 37.48613, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Rozas de Madrid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87371, 40.49292, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Torres de Cotillas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.24188, 38.02822, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lebrija'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.07529, 36.92077, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leganés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.7635, 40.32718, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['León'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.57032, 42.60003, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lepe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.20433, 37.25482, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lérida'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.62556, 41.61389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Linares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.63602, 38.09519, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Liria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.59783, 39.62894, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lloret de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.84565, 41.69993, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Logroño'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45, 42.46667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Loja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.15129, 37.16887, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lorca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.7017, 37.67119, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Barrios'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.49213, 36.18482, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Llanos de Aridane'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-17.91821, 28.65851, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Palacios y Villafranca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92433, 37.16181, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Realejos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.58335, 28.36739, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.48522, 37.40881, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lugo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.55602, 43.00992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madrid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70256, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Alcor'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.74951, 37.37301, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Aljarafe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.06391, 37.34461, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Majadahonda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87182, 40.47353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Málaga'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.42034, 36.72016, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manacor'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.20955, 39.56964, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manises'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46349, 39.49139, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manlleu'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28476, 42.00228, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manresa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.82656, 41.72498, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Maracena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.63493, 37.20764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marbella'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.88583, 36.51543, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marín'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.7, 42.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martorell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.93062, 41.47402, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.97264, 37.72107, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mataró'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.4445, 41.54211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazarrón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.31493, 37.5992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medina del Campo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.91413, 41.31239, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mejorada del Campo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.48194, 40.39283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Melilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.93833, 35.29369, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mérida'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.34366, 38.91611, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mieres'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.76667, 43.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mijas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63728, 36.59575, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Miranda de Ebro'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.94695, 42.6865, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mislata'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41825, 39.47523, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mogán'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.72538, 27.88385, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moguer'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.83851, 37.27559, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Molina de Segura'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.20763, 38.05456, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.39551, 39.54555, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mondragón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.48977, 43.06441, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63805, 37.58627, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Morón de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.45403, 37.12084, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Móstoles'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.86496, 40.32234, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Motril'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.5179, 36.75066, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Muchamiel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44529, 38.4158, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Murcia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.13004, 37.98704, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Narón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.19082, 43.50175, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Navalcarnero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.01197, 40.28908, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nerja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.8744, 36.75278, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Níjar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.20595, 36.96655, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novelda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.76773, 38.38479, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oleiros'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.31667, 43.33333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olesa de Montserrat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.89407, 41.54372, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oliva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11935, 38.91971, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olot'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.49012, 42.18096, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.96667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orense'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.86407, 42.33669, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orihuela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.94401, 38.08483, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oviedo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.84476, 43.36029, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paiporta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41667, 39.43333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pájara'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-14.1076, 28.35039, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palafrugell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.1631, 41.91738, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.52406, 42.00955, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palma del Río'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.28121, 37.70024, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palma de Mallorca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.65024, 39.56939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pamplona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64323, 42.81687, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paracuellos de Jarama'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.52775, 40.50353, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76752, 40.23604, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paterna'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43333, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Petrel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.77549, 38.48289, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pilar de la Horadada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79256, 37.86591, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pineda de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.6889, 41.62763, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pinto'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69999, 40.24147, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Plasencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.08845, 40.03116, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ponferrada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.59619, 42.54664, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pontevedra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.64435, 42.431, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portugalete'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02064, 43.32099, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozuelo de Alarcón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.81338, 40.43293, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Priego de Córdoba'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.19523, 37.43807, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto de la Cruz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.54867, 28.41397, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto del Rosario'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.86272, 28.50038, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puertollano'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10734, 38.68712, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto Real'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.19011, 36.52819, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Redondela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.6096, 42.28337, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rentería'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.43333, 43.31667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Requena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10044, 39.48834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reus'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.10687, 41.15612, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rincón de la Victoria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.27583, 36.71715, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ripollet'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.15739, 41.49686, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rojales'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.72544, 38.08799, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ronda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.16709, 36.74231, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Roquetas de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.61475, 36.76419, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rota'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3622, 36.62545, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rubí'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.03305, 41.49226, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sabadell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10942, 41.54329, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sagunto'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.26667, 39.68333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salamanca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66388, 40.96882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salou'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.14163, 41.07663, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salt'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79281, 41.97489, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Andrés del Rabanedo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.61671, 42.61174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Antonio Abad'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.99665, 37.61767, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Cristóbal de la Laguna'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.32014, 28.4853, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.19817, 36.4759, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando de Henares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.53261, 40.42386, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Javier'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.83736, 37.80626, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San José'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.10912, 36.76048, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Juan de Alicante'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43623, 38.40148, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Juan de Aznalfarache'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.03731, 37.35813, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanlúcar de Barrameda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3515, 36.77808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro del Pinatar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79102, 37.83568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Roque'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.38415, 36.21067, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Sebastián'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.9, 43.56667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Sebastián de los Reyes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.61588, 40.54433, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Cruz de Tenerife'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.25462, 28.46824, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santander'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.80444, 43.46472, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Pola'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5658, 38.19165, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago de Compostela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.54569, 42.88052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santurce'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.03248, 43.32842, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Segovia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.11839, 40.94808, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sestao'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.00716, 43.30975, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sevilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.97317, 37.38283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.4775, 43.08347, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sitges'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.81193, 41.23506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Soria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.46883, 41.76401, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sueca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.31114, 39.2026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tacoronte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.41016, 28.47688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Talavera de la Reina'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.83076, 39.96348, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tarragona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.25, 41.11667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teguise'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.56397, 29.06049, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Telde'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41915, 27.99243, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teruel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10646, 40.3456, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tías'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.64502, 28.96108, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toledo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.02263, 39.8581, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.04589, 37.37281, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomelloso'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02156, 39.15759, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrejón de Ardoz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.46973, 40.45535, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelavega'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.04785, 43.34943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelodones'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92658, 40.57654, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torremolinos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.49976, 36.62035, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46546, 39.43705, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrevieja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.68222, 37.97872, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tortosa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.5216, 40.81249, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Totana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.50229, 37.7688, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tres Cantos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70806, 40.60092, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tudela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.60452, 42.06166, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Úbeda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.3705, 38.01328, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Utrera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.78093, 37.18516, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdemoro'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67887, 40.19081, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdepeñas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.38483, 38.76211, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.37739, 39.46975, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valladolid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72372, 41.65518, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valls'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.24993, 41.28612, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vélez-Málaga'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10045, 36.77262, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vícar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.64273, 36.83155, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vic'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25486, 41.93012, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.72264, 42.23282, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viladecans'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.01427, 41.31405, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vilaseca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25528, 42.06174, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villajoyosa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.23346, 38.50754, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villanueva de la Serena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.7974, 38.97655, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarreal'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.21533, 38.72572, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarrobledo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.60119, 39.26992, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villaviciosa de Odón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.90011, 40.35692, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.86568, 38.6373, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitoria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.67268, 42.84998, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yecla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.11468, 38.61365, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zamora'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.74456, 41.50633, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zaragoza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.87734, 41.65606, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alacuás'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.461, 39.45568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Guadaíra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.83951, 37.33791, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aldaya'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46005, 39.46569, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alfaz del Pi'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.10321, 38.58055, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almazora'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.06313, 39.94729, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barbate'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92186, 36.19237, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calviá'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.50621, 39.5657, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellón de la Plana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.03333, 39.98333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Collado Villalba'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.00486, 40.63506, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuart de Poblet'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43937, 39.48139, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Éibar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.47158, 43.18493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Esparraguera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.87025, 41.53809, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galdácano'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.83333, 43.23333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gandía'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.18333, 38.96667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guecho'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.01146, 43.35689, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hospitalet de Llobregat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10028, 41.35967, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Irún'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78938, 43.33904, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Játiva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.51852, 38.99042, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jávea'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.16667, 38.78333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Coruña'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.396, 43.37135, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Langreo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.68416, 43.29568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lejona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.98333, 43.33333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mahón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.26583, 39.88853, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mollet del Vallés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.21306, 41.54026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onteniente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.60603, 38.82191, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Picasent'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45949, 39.3635, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla de Vallbona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.55468, 39.59747, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puente Genil'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.76686, 37.38943, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Andrés de la Barca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.97187, 41.44659, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adeje'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.726, 28.12271, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02055, 36.74961, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Águilas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.58289, 37.4063, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agüimes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.44609, 27.90539, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Albacete'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.85643, 38.99424, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alboraya'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.35, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Henares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.35996, 40.48205, 4326)::geography,3000)::geometry, 4326))" should true
}

function test_geocoding_functions_namedplace_france() {

    # France tests - 2km of tolerance for the city point without country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aix-en-Provence'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.44973, 43.5283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amiens'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3, 49.9, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Angers'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.55, 47.46667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Besançon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.01815, 47.24878, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bordeaux'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5805, 44.84044, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boulogne-Billancourt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25, 48.83333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.35912, 49.18585, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Argenteuil'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25, 48.95, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asnières-sur-Seine'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28333, 48.91667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aulnay-sous-Bois'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.49402, 48.93814, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avignon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.80892, 43.94834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calais'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.85635, 50.95194, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Clermont-Ferrand'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.08628, 45.77966, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colombes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25404, 48.91882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Créteil'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.46667, 48.78333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dijon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.01667, 47.31667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort-de-France'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-61.07334, 14.60892, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Grenoble'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.71667, 45.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Rochelle'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.15, 46.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Le Havre'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.10767, 49.4938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Le Mans'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.2, 48, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lille'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.05858, 50.63297, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Limoges'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.25781, 45.83153, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lyon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.84671, 45.74846, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marseille'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.38107, 43.29695, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Metz'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.17269, 49.11911, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montpellier'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.87723, 43.61092, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montreuil'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.44322, 48.86415, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mulhouse'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.33333, 47.75, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nancy'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.18496, 48.68439, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanterre'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.20675, 48.89198, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nantes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.55336, 47.21725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nice'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.26608, 43.70313, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nîmes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.35, 43.83333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orléans'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.90389, 47.90289, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paris'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3488, 48.85341, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pau'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.36667, 43.3, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perpignan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.89541, 42.69764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Poitiers'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.33333, 46.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reims'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.03333, 49.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rennes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.67429, 48.11198, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Roubaix'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.17456, 50.69421, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rouen'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.09932, 49.44313, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saint-Denis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(55.4504, -20.88231, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saint-Étienne'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.39, 45.43389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saint-Paul'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(55.27071, -21.00963, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Strasbourg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.74553, 48.58392, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toulon'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.93333, 43.11667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toulouse'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.44367, 43.60426, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tourcoing'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.16117, 50.72391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tours'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.68333, 47.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Versailles'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.13333, 48.8, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villeurbanne'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.88333, 45.76667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitry-sur-Seine'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.40332, 48.78716, 4326)::geography,3000)::geometry, 4326))" should true

    # France tests - 2km of tolerance for the city point with country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aix-en-Provence'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.44973, 43.5283, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amiens'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3, 49.9, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Angers'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.55, 47.46667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Besançon'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.01815, 47.24878, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bordeaux'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5805, 44.84044, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boulogne-Billancourt'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25, 48.83333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brest'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.48333, 48.4, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caen'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.35912, 49.18585, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Argenteuil'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25, 48.95, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asnières-sur-Seine'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28333, 48.91667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aulnay-sous-Bois'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.49402, 48.93814, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avignon'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.80892, 43.94834, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calais'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.85635, 50.95194, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Clermont-Ferrand'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.08628, 45.77966, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colombes'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25404, 48.91882, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Créteil'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.46667, 48.78333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dijon'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.01667, 47.31667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Grenoble'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.71667, 45.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Rochelle'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.15, 46.16667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Le Havre'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.10767, 49.4938, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Le Mans'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.2, 48, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lille'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.05858, 50.63297, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Limoges'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.25781, 45.83153, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lyon'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.84671, 45.74846, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marseille'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.38107, 43.29695, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Metz'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.17269, 49.11911, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montpellier'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.87723, 43.61092, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montreuil'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.44322, 48.86415, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mulhouse'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.33333, 47.75, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nancy'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.18496, 48.68439, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nanterre'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.20675, 48.89198, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nantes'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.55336, 47.21725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nice'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.26608, 43.70313, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nîmes'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.35, 43.83333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orléans'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.90389, 47.90289, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paris'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3488, 48.85341, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pau'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.36667, 43.3, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perpignan'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.89541, 42.69764, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Poitiers'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.33333, 46.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reims'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.03333, 49.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rennes'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.67429, 48.11198, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Roubaix'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.17456, 50.69421, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rouen'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.09932, 49.44313, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saint-Étienne'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.39, 45.43389, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Strasbourg'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.74553, 48.58392, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toulon'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(5.93333, 43.11667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toulouse'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.44367, 43.60426, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tourcoing'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.16117, 50.72391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tours'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.68333, 47.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Versailles'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.13333, 48.8, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villeurbanne'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.88333, 45.76667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitry-sur-Seine'], 'FRA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.40332, 48.78716, 4326)::geography,3000)::geometry, 4326))" should true
}

function test_geocoding_functions_namedplace_northamerica() {

    # North America tests - 2km of tolerance for the city point without country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Philadelphia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.16379, 39.95233, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chihuahua'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.08889, 28.63528, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baltimore'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.61219, 39.29038, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Columbus'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.99879, 39.96118, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro Sula'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-88.025, 15.50417, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Culiacán'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-107.38782, 24.79032, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalupe'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.25646, 25.67678, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aguascalientes'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-102.28259, 21.88234, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Francisco'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.41942, 37.77493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mississauga'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.6583, 43.5789, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reynosa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.28835, 26.08061, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saltillo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.0053, 25.42321, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Port-au-Prince'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-72.335, 18.53917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monterrey'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.31847, 25.67507, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nezahualcóyotl'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.45559, 17.25375, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Austin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.74306, 30.26715, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago de Querétaro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.38806, 20.58806, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Louisville'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-85.75941, 38.25424, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Antonio'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.49363, 29.42412, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Seattle'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.33207, 47.60621, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chicago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.65005, 41.85003, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Memphis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.04898, 35.14953, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dallas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.80667, 32.78306, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.38304, 23.13302, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calgary'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-114.08529, 51.05011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oklahoma City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.51643, 35.46756, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.20193, 19.04334, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guatemala City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.51327, 14.64072, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Vegas'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.13722, 36.17497, 4326)::geography,10000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Detroit'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-83.04575, 42.33143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portland'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.67621, 45.52345, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hermosillo'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-110.97732, 29.1026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Managua'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.2504, 12.13282, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mérida'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-89.61696, 20.97537, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Juárez'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.09582, 25.64724, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Edmonton'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.46871, 53.55014, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Morelia'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.18443, 19.70078, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Luis Potosí'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.97916, 22.14982, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Houston'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-95.36327, 29.76328, 4326)::geography,4000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Jose'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-121.89496, 37.33939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['León'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.671, 21.13052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexicali'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.45446, 32.62781, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Charlotte'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.84313, 35.22709, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Diego'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.15726, 32.71533, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phoenix'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-112.07404, 33.44838, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Paso'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.48693, 31.75872, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tegucigalpa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.20681, 14.0818, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.39182, 20.66682, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denver'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-104.9847, 39.73915, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acapulco'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.51028, 16.11417, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ottawa'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.69812, 45.41117, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort Worth'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.32085, 32.72541, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boston'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.05977, 42.35843, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexico City'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.12766, 19.42847, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tijuana'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.00371, 32.5027, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nashville'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.78444, 36.16589, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jacksonville'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-81.65565, 30.33218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cancún'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.84656, 21.17429, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Angeles'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-118.24368, 34.05223, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Indianapolis'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.15804, 39.76838, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.79358, 17.99702, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torreón'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.38611, 18.41194, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zapopan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.38479, 20.72356, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vancouver'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-123.11934, 49.24966, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toronto'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.4163, 43.70011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Winnipeg'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.14704, 49.8844, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlaquepaque'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.29327, 20.64091, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlalnepantla'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.19538, 19.54005, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ecatepec de Morelos'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.06601, 19.61725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chimalhuacán'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.95038, 19.42155, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Naucalpan'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.23963, 19.47851, 4326)::geography,3000)::geometry, 4326))" should true

    # North America tests - 2km of tolerance for the city point with country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Philadelphia'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.16379, 39.95233, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chihuahua'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.08889, 28.63528, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baltimore'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.61219, 39.29038, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Columbus'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.99879, 39.96118, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro Sula'], 'Honduras')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-88.025, 15.50417, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Culiacán'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-107.38782, 24.79032, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalupe'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.25646, 25.67678, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aguascalientes'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-102.28259, 21.88234, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Francisco'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.41942, 37.77493, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mississauga'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.6583, 43.5789, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reynosa'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.28835, 26.08061, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saltillo'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.0053, 25.42321, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Port-au-Prince'], 'Haiti')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-72.335, 18.53917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monterrey'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.31847, 25.67507, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nezahualcóyotl'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.45559, 17.25375, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Austin'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.74306, 30.26715, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago de Querétaro'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.38806, 20.58806, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Louisville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-85.75941, 38.25424, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Antonio'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.49363, 29.42412, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Seattle'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.33207, 47.60621, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chicago'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.65005, 41.85003, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Memphis'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.04898, 35.14953, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dallas'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.80667, 32.78306, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havana'], 'Cuba')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.38304, 23.13302, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calgary'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-114.08529, 51.05011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oklahoma City'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.51643, 35.46756, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.20193, 19.04334, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guatemala City'], 'Guatemala')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.51327, 14.64072, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Vegas'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.13722, 36.17497, 4326)::geography,10000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Detroit'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-83.04575, 42.33143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portland'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.67621, 45.52345, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hermosillo'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-110.97732, 29.1026, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Managua'], 'Nicaragua')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.2504, 12.13282, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mérida'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-89.61696, 20.97537, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Juárez'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.09582, 25.64724, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Edmonton'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.46871, 53.55014, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Morelia'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.18443, 19.70078, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Luis Potosí'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.97916, 22.14982, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Houston'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-95.36327, 29.76328, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Jose'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-121.89496, 37.33939, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['León'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.671, 21.13052, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexicali'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.45446, 32.62781, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Charlotte'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.84313, 35.22709, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Diego'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.15726, 32.71533, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phoenix'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-112.07404, 33.44838, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Paso'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.48693, 31.75872, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tegucigalpa'], 'Honduras')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.20681, 14.0818, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.39182, 20.66682, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denver'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-104.9847, 39.73915, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acapulco'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.51028, 16.11417, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ottawa'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.69812, 45.41117, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort Worth'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.32085, 32.72541, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boston'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.05977, 42.35843, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexico City'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.12766, 19.42847, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tijuana'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.00371, 32.5027, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nashville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.78444, 36.16589, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jacksonville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-81.65565, 30.33218, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cancún'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.84656, 21.17429, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Angeles'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-118.24368, 34.05223, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Indianapolis'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.15804, 39.76838, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montreal'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-73.58781, 45.50884, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston'], 'Jamaica')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.79358, 17.99702, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torreón'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.38611, 18.41194, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zapopan'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.38479, 20.72356, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vancouver'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-123.11934, 49.24966, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Washington'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.50829, 37.13054, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toronto'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.4163, 43.70011, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Winnipeg'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.14704, 49.8844, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlaquepaque'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.29327, 20.64091, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlalnepantla'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.19538, 19.54005, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ecatepec de Morelos'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.06601, 19.61725, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chimalhuacán'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.95038, 19.42155, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Naucalpan'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.23963, 19.47851, 4326)::geography,3000)::geometry, 4326))" should true
}

function test_geocoding_functions_namedplace_england() {

    # England tests - 2km of tolerance for the city point without country
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barnet'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2, 51.65, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bexley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.14866, 51.44162, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Birmingham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.89983, 52.48142, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blackburn'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.48333, 53.75, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blackpool'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.05, 53.81667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bolton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.43333, 53.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bournemouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.8795, 50.72048, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bradford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.75206, 53.79391, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brent'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.3023, 51.55306, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brighton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.13947, 50.82838, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bristol'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.59665, 51.45523, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bromley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.01519, 51.40606, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambridge'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.11667, 52.2, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chesterfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.41667, 53.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colchester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.90421, 51.88921, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coventry'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.51217, 52.40656, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crawley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.18312, 51.11303, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Croydon'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.1, 51.38333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Derby'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.47663, 52.92277, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dudley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.08333, 52.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ealing'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.30204, 51.51216, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Eastbourne'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.28453, 50.76871, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Enfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08497, 51.65147, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Exeter'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.52751, 50.7236, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gloucester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.2431, 51.86568, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Greenwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.01176, 51.47785, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hackney'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.05, 51.55, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haringey'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08333, 51.58333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Harrow'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.33208, 51.57835, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hillingdon'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45293, 51.53291, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hounslow'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.36092, 51.46839, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huddersfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78416, 53.64904, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ipswich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.15545, 52.05917, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Islington'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.10304, 51.53622, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston upon Thames'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2974, 51.41259, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lambeth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11152, 51.49635, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Richmond upon Thames'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.30212, 51.45689, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leeds'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.54785, 53.79648, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leicester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.13169, 52.6386, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lewisham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.01193, 51.46431, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Liverpool'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.97794, 53.41058, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Luton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41748, 51.87967, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manchester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.23743, 53.48095, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Merton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.1, 50.88333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Middlesbrough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.23483, 54.57623, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Newcastle upon Tyne'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.61396, 54.97328, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Newham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.71667, 55.53333, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Northampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.88333, 52.25, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Norwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.29834, 52.62783, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nottingham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.15047, 52.9536, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oldham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.1183, 53.54051, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oxford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.25596, 51.75222, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Peterborough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.24777, 52.57364, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Plymouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.14305, 50.37153, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Poole'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2, 50.71667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portsmouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.09125, 50.79899, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Preston'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.71667, 53.76667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reading'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.97113, 51.45625, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Redbridge'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.46667, 50.91667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rotherham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.35678, 53.43012, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sheffield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.4659, 53.38297, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Slough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.59541, 51.50949, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.40428, 50.90395, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southend-on-Sea'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.71433, 51.53782, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southwark'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08333, 51.5, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['St Helens'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.73333, 53.45, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stockport'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.15761, 53.40979, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stoke-on-Trent'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.18538, 53.00415, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sunderland'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.38222, 54.90465, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sutton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2, 51.35, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sutton Coldfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.81667, 52.56667, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Swindon'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78116, 51.55797, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Walsall'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.98396, 52.58528, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wandsworth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.20784, 51.4577, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Watford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.39602, 51.65531, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['West Bromwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.9945, 52.51868, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wolverhampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.12296, 52.58547, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['York'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.08271, 53.95763, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havering'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.18608, 51.61557, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston upon Hull'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.33525, 53.7446, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Westminster'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11667, 51.5, 4326)::geography,3000)::geometry, 4326))" should true

}


#################################################### TESTS END HERE ####################################################
