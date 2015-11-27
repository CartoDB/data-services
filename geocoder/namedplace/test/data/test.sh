#!/bin/sh

#################################################### TESTS GO HERE ####################################################


function test_geocoding_data_namedplace_shanghai() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(121.45806 31.22222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shanghai' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_buenos_aires() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-58.37723 -34.61315)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Buenos Aires' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_mumbai() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(72.88261 19.07283)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Mumbai' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_mexico_city() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-99.12766 19.42847)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Mexico City' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_beijing() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(116.39723 39.9075)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Beijing' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_karachi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(67.0822 24.9056)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Karachi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_istanbul() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(28.94966 41.01384)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'İstanbul' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tianjin() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(117.17667 39.14222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tianjin' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_guangzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(113.25 23.11667)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Guangzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_delhi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(77.23149 28.65195)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Delhi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_manila() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.9822 14.6042)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Manila' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_moscow() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(37.61556 55.75222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Moscow' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_shenzhen() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.0683 22.54554)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shenzhen' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_dhaka() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(90.40744 23.7104)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Dhaka' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_seoul() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(126.9784 37.566)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Seoul' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_são_paulo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-46.63611 -23.5475)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'São Paulo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_wuhan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.26667 30.58333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Wuhan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_lagos() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(3.39467 6.45407)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Lagos' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_jakarta() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(106.84513 -6.21462)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Jakarta' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tokyo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(139.69171 35.6895)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tokyo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_new_york() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-74.00597 40.71427)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'New York' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_dongguan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(113.74472 23.04889)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Dongguan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_taipei() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(121.53185 25.04776)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Taipei' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kinshasa() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(15.31357 -4.32758)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kinshasa' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_lima() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-77.02824 -12.04318)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Lima' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_cairo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(31.24967 30.06263)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Cairo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bogotá() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-74.08175 4.60971)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bogotá' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_city_of_london() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-0.09184 51.51279)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'City of London' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_london() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-0.12574 51.50853)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'London' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_chongqing() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(106.55278 29.56278)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Chongqing' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_chengdu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(104.06667 30.66667)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Chengdu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nanjing() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(118.77778 32.06167)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nanjing' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tehrān() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(51.42151 35.69439)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tehrān' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nanchong() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(106.08473 30.79508)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nanchong' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hong_kong() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.15769 22.28552)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hong Kong' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_xian() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(108.92861 34.25833)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Xi’an' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_lahore() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(74.34361 31.54972)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Lahore' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_shenyang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(123.43278 41.79222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shenyang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_changzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(119.95401 31.77359)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Changzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hangzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.16142 30.29365)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hangzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_rio_de_janeiro() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-43.2075 -22.90278)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Rio de Janeiro' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_harbin() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(126.65 45.75)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Harbin' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_baghdad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(44.40088 33.34058)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Baghdad' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_taian() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(117.12 36.18528)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tai’an' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_suzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.59538 31.30408)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Suzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_shantou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(116.71479 23.36814)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shantou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bangkok() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(100.50144 13.75398)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bangkok' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bangalore() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(77.59369 12.97194)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bangalore' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_saint_petersburg() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(30.31413 59.93863)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Saint Petersburg' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_santiago() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-70.64827 -33.45694)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Santiago' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_santiago_de_los_caballeros() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-70.69703 19.4517)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Santiago de los Caballeros' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kolkata() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(88.36304 22.56263)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kolkata' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_sydney() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(151.20732 -33.86785)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Sydney' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_yangon() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(96.15611 16.80528)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Yangon' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_jinan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(116.99722 36.66833)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Jinan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_chennai() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(80.27847 13.08784)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Chennai' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_zhengzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(113.64861 34.75778)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Zhengzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_melbourne() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(144.96332 -37.814)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Melbourne' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_riyadh() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(46.72185 24.68773)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Riyadh' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_changchun() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(125.32278 43.88)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Changchun' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_dalian() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(121.60222 38.91222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Dalian' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_chittagong() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(91.83168 22.3384)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Chittagong' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kunming() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(102.71833 25.03889)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kunming' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_alexandria() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(29.95527 31.21564)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Alexandria' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_los_angeles() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-118.24368 34.05223)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Los Angeles' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ahmedabad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(72.58727 23.02579)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ahmedabad' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_qingdao() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.36939 36.06605)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Qingdao' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_busan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(129.04028 35.10278)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Busan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_abidjan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-4.01266 5.30966)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Abidjan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kano() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(8.51672 12.00012)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kano' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_foshan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(113.13148 23.02677)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Foshan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hyderabad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(68.37366 25.39242)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hyderabad' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hyderabad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(78.45636 17.38405)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hyderabad' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_puyang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(119.88872 29.45679)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Puyang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_yokohama() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(139.6425 35.44778)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Yokohama' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ibadan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(3.90591 7.37756)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ibadan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_singapore() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(103.85007 1.28967)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Singapore' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_wuxi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.28857 31.56887)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Wuxi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_xiamen() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(118.08187 24.47979)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Xiamen' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ankara() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(32.85427 39.91987)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ankara' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tianshui() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(105.74238 34.57952)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tianshui' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ningbo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(121.54945 29.87819)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ningbo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ho_chi_minh_city() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(106.62965 10.82302)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ho Chi Minh City' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_shiyan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(110.77806 32.6475)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shiyan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_cape_town() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(18.42322 -33.92584)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Cape Town' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_taiyuan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(112.56028 37.86944)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Taiyuan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_berlin() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(13.41053 52.52437)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Berlin' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tangshan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(118.18333 39.63333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tangshan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hefei() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(117.28083 31.86389)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hefei' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_montreal() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-73.58781 45.50884)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Montréal' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_madrid() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-3.70256 40.4165)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Madrid' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_pyongyang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(125.75432 39.03385)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Pyongyang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_casablanca() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-7.61138 33.58831)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Casablanca' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_zibo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(118.06333 36.79056)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Zibo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_zhongshan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(110.5723 21.31992)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Zhongshan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_durban() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(31.0292 -29.8579)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Durban' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_changsha() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(112.97087 28.19874)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Changsha' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kabul() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(69.17233 34.52813)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kabul' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_urumqi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(87.60046 43.80096)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ürümqi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_caracas() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-66.87919 10.48801)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Caracas' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_pune() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(73.85535 18.51957)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Pune' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_surat() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(72.83023 21.19594)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Sūrat' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_jeddah() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(39.19797 21.54238)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Jeddah' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_shijiazhuang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.47861 38.04139)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Shijiazhuang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kanpur() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(80.34627 26.4478)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kānpur' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kiev() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(30.5238 50.45466)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kiev' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_luanda() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(13.23432 -8.83682)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Luanda' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_quezon_city() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(121.0509 14.6488)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Quezon City' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_addis_ababa() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(38.74689 9.02497)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Addis Ababa' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nairobi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(36.81667 -1.28333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nairobi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_salvador() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-38.51083 -12.97111)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Salvador' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_jaipur() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(75.78781 26.91962)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Jaipur' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_dar_es_salaam() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(39.26951 -6.82349)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Dar es Salaam' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_chicago() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-87.65005 41.85003)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Chicago' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_lanzhou() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(103.83987 36.05701)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Lanzhou' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_incheon() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(126.70515 37.45646)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Incheon' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_yunfu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(112.03954 22.92833)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Yunfu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_al_başrah() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(47.79747 30.53302)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Al Başrah' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_navi_mumbai() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(73.01582 19.03681)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Navi Mumbai' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_toronto() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-79.4163 43.70011)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Toronto' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_osaka-shi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(135.50218 34.69374)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ōsaka-shi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_mogadishu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(45.34375 2.03711)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Mogadishu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_daegu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(128.59111 35.87028)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Daegu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_faisalabad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(73.08333 31.41667)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Faisalābād' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_izmir() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(27.13838 38.41273)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'İzmir' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_dakar() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-17.44406 14.6937)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Dakar' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_grand_dakar() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-17.45472 14.71331)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Grand Dakar' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_lucknow() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(80.92313 26.83928)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Lucknow' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_al_jizah() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(31.21093 30.00808)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Al Jīzah' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_fortaleza() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-38.54306 -3.71722)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Fortaleza' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_cali() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-76.5225 3.43722)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Cali' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_surabaya() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(112.75083 -7.24917)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Surabaya' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_belo_horizonte() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-43.93778 -19.92083)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Belo Horizonte' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nanchang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(115.85306 28.68396)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nanchang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_grand_dakar() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-17.45472 14.71331)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Grand Dakar' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_rome() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(12.51133 41.89193)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Rome' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_mashhad() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(59.56796 36.31559)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Mashhad' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_brooklyn() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-73.94958 40.6501)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Brooklyn' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nagpur() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(79.08491 21.14631)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nagpur' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_maracaibo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-71.64056 10.63167)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Maracaibo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_brasilia() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-47.92972 -15.77972)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Brasília' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_santo_domingo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-69.98857 18.50012)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Santo Domingo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_nagoya_shi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(136.90641 35.18147)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Nagoya-shi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_brisbane() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(153.02809 -27.46794)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Brisbane' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_havana() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-82.38304 23.13302)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Havana' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_paris() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(2.3488 48.85341)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Paris' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_houston() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-95.36327 29.76328)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Houston' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_al_mawsil_al_jadidah() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(43.1049 36.33306)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Al Mawşil al Jadīdah' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_johannesburg() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(28.04363 -26.20227)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Johannesburg' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kowloon() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.18333 22.31667)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kowloon' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_al_basrah_al_qadimah() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(47.81507 30.50316)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Al Başrah al Qadīmah' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_almaty() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(76.92848 43.25654)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Almaty' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_medellin() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-75.56359 6.25184)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Medellín' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tashkent() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(69.21627 41.26465)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tashkent' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_algiers() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(3.04197 36.7525)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Algiers' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_khartoum() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(32.53241 15.55177)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Khartoum' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_accra() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-0.1969 5.55602)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Accra' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_guayaquil() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-79.90795 -2.20584)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Guayaquil' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ordos() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(109.78157 39.6086)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ordos' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_sanaa() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(44.20667 15.35472)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Sanaa' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_beirut() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(35.49442 33.88894)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Beirut' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_perth() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(115.8614 -31.95224)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Perth' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_sapporo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(141.34695 43.06417)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Sapporo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_jilin() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(126.56028 43.85083)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Jilin' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bucharest() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(26.10626 44.43225)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bucharest' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_camayenne() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-13.68778 9.535)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Camayenne' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_vancouver() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-123.11934 49.24966)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Vancouver' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_indore() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(75.8333 22.71792)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Indore' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_iztapalapa() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-99.0671 19.35738)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Iztapalapa' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ecatepec() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-99.06601 19.61725)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ecatepec' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_conakry() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-13.67729 9.53795)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Conakry' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_maracay() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-67.59583 10.24694)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Maracay' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_medan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(98.66667 3.58333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Medan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_rawalpindi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(73.0679 33.6007)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Rawalpindi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_minsk() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(27.56667 53.9)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Minsk' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_budapest() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(19.03991 47.49801)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Budapest' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_mosul() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(43.11889 36.335)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Mosul' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hamburg() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(10.01534 53.57532)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hamburg' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_curitiba() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-49.27306 -25.42778)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Curitiba' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_warsaw() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(21.01178 52.22977)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Warsaw' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bandung() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(107.61861 -6.90389)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bandung' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_soweto() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(27.85849 -26.26781)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Soweto' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_vienna() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(16.37208 48.20849)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Vienna' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_rabat() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-6.83255 34.01325)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Rabat' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_guadalajara() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-103.39182 20.66682)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Guadalajara' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_barcelona() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(2.15899 41.38879)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Barcelona' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_pretoria() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(28.18783 -25.74486)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Pretoria' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_aleppo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(37.16117 36.20124)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Aleppo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_visakhapatnam() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(83.20161 17.68009)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Visakhapatnam' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_patna() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(85.11936 25.60222)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Patna' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bhopal() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(77.40289 23.25469)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bhopal' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_manaus() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-60.025 -3.10194)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Manaus' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_xinyang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(114.06556 32.12278)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Xinyang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_puebla() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-98.20193 19.04334)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Puebla' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kaduna() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(7.43879 10.52641)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kaduna' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_phnom_penh() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(104.91601 11.56245)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Phnom Penh' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_damascus() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(36.29128 33.5102)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Damascus' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_isfahan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(51.67462 32.65246)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Isfahan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ludhiana() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(75.85379 30.91204)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ludhiāna' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_harare() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(31.05337 -17.82772)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Harare' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kobe() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(135.183 34.6913)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kobe' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_philadelphia() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-75.16379 39.95233)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Philadelphia' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bekasi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(106.9896 -6.2349)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bekasi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kaohsiung() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(120.31333 22.61626)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kaohsiung' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_ciudad_juarez() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-106.48333 31.73333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Ciudad Juárez' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_manhattan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-73.96625 40.78343)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Manhattan' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_asuncion() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-57.63591 -25.30066)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Asunción' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_recife() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-34.88111 -8.05389)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Recife' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_daejeon() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(127.41972 36.32139)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Daejeon' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kumasi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-1.62443 6.68848)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kumasi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kota_bharu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(102.2386 6.13328)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kota Bharu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kyoto() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(135.75385 35.02107)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kyoto' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kuala_lumpur() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(101.68653 3.1412)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kuala Lumpur' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_karaj() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(50.99155 35.83266)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Karaj' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_phoenix() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-112.07404 33.44838)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Phoenix' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kathmandu() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(85.3206 27.70169)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kathmandu' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_palembang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(104.7458 -2.91673)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Palembang' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_multan() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(71.47528 30.19556)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Multān' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_hanoi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(105.84117 21.0245)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Hanoi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_kharkiv() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(36.25272 49.98081)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Kharkiv' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_agra() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(78.01667 27.18333)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Āgra' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_tabriz() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(46.2919 38.08)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Tabrīz' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_novosibirsk() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(82.9346 55.0415)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Novosibirsk' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_gwangju() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(126.91556 35.15472)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Gwangju' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_bursa() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(29.08403 40.19266)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Bursa' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_vadodara() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(73.20812 22.29941)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Vadodara' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_belem() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-48.50444 -1.45583)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Belém' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_fushun() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(123.92333 41.85583)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Fushun' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_quito() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(-78.52495 -0.22985)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Quito' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_fukuoka-shi() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(130.41806 33.60639)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Fukuoka-shi' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_antananarivo() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(47.53613 -18.91368)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Antananarivo' order by population desc limit 1" should true
}

function test_geocoding_data_namedplace_luoyang() { 
    sql "SELECT ST_Intersects(ST_GeomFromText('POINT(112.45361 34.68361)' , 4326), ST_Buffer(the_geom::geography, 1000)) FROM global_cities_points_limited where name = 'Luoyang' order by population desc limit 1" should true
}

#################################################### TESTS END HERE ####################################################
