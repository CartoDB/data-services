#!/bin/sh

#################################################### TESTS GO HERE ####################################################
function test_geocoding_functions_namedplace() {

    # checks that the result is false and no geometry is returned for a non-recognised named place
    sql "SELECT (geocode_namedplace(Array['Null island is not an island'])).success" should false
    sql "SELECT (geocode_namedplace(Array['Null island is not an island'])).geom is null" should true

    # check that the returned geometry is a point
    sql "SELECT ST_GeometryType((geocode_namedplace(Array['Elx'])).geom)" should ST_Point

}

function test_geocoding_functions_namedplace_newyork() {


    # big cities: more than 1 million inhabitants from populated places (some coordinates have been adjusted)
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'NY', 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], null, 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_some_top_cities() {


    sql "SELECT ST_Intersects((geocode_namedplace(Array['Frankfurt'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.53333, 49.68333, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rio de Janeiro'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-43.2075, -22.90278, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barcelona'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.18142446061915, 41.3852454385475, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amsterdam'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.91469431740097, 52.3519145466644, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zürich'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.54806427184257, 47.3819336709934, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brussels'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.33137074969045, 50.8352629353303, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lusaka'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(28.2813817361143, -15.4146984093359, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dublin'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.25085154039107, 53.3350069945849, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phoenix'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-112.07404, 33.44838, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-70.64827, -33.45694, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chicago'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.65005, 41.85003, 4326) ::geography,5000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paris'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.33138946713035, 48.8686387898146, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calgary'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-114.08529, 51.05011, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rome'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.481312562874, 41.8979014850989, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Francisco'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.417168773552, 37.7691956296874, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vancouver'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-123.123590076394, 49.2753624427117, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madrid'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.68529754461252, 40.4019721231138, 4326) ::geography,3000)::geometry, 4326))" should true
    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hong Kong'])).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(114.15769, 22.28552, 4326) ::geography,3000)::geometry, 4326))" should true

}

    # Germany tests - 2km of tolerance for the city point with country

function test_geocoding_functions_namedplace_kassel_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kassel'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.5, 51.31667, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bielefeld_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bielefeld'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.53333, 52.03333, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_erfurt_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erfurt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.03283, 50.9787, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_frankfurt_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Frankfurt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.53333, 49.68333, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_berlin_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Berlin'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.41053, 52.52437, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_osnabrück_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Osnabrück'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.0498, 52.27264, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_freiburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Freiburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.85222, 47.9959, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_munich_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Munich'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.57549, 48.13743, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bochum_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bochum'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.21648, 51.48165, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_regensburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Regensburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11923, 49.03451, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_salzgitter_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salzgitter'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.33144, 52.15256, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_saarbrücken_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saarbrücken'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98165, 49.2354, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_dortmund_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dortmund'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.466, 51.51494, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_heilbronn_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heilbronn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22054, 49.13995, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_remscheid_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Remscheid'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.1925, 51.17983, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_düsseldorf_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Düsseldorf'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.77616, 51.22172, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_gelsenkirchen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gelsenkirchen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.12283, 51.5075, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_halle_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Halle'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.36083, 52.06007, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_ulm_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ulm'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.99155, 48.39841, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_leipzig_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leipzig'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.37129, 51.33962, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_trier_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trier'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.63935, 49.75565, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_hamm_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamm'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.82089, 51.68033, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_heidelberg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Heidelberg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69079, 49.40768, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_magdeburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Magdeburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.62916, 52.12773, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_herne_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Herne'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.22572, 51.5388, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bergisch_gladbach_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergisch Gladbach'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.13298, 50.9856, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_lübeck_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lübeck'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.68729, 53.86893, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_recklinghausen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Recklinghausen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.19738, 51.61379, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_koblenz_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Koblenz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57883, 50.35357, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_wolfsburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wolfsburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.7815, 52.42452, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_ingolstadt_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ingolstadt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.42372, 48.76508, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_kiel_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kiel'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.13489, 54.32133, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_braunschweig_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Braunschweig'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.52673, 52.26594, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_stuttgart_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stuttgart'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.17702, 48.78232, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_karlsruhe_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Karlsruhe'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.40444, 49.00937, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_darmstadt_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Darmstadt'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.65027, 49.87167, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_essen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Essen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.01228, 51.45657, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_mönchengladbach_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mönchengladbach'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.44172, 51.18539, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_augsburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Augsburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.89851, 48.37154, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bottrop_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bottrop'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.9285, 51.52392, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_fürth_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fürth'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98856, 49.47593, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_moers_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moers'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.6326, 51.45342, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_hagen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hagen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.47168, 51.36081, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bremerhaven_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremerhaven'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.57673, 53.55021, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_aachen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aachen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.08342, 50.77664, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_wiesbaden_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wiesbaden'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.24932, 50.08258, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_oberhausen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oberhausen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88074, 51.47311, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bremen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bremen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.80777, 53.07516, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_mannheim_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mannheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47955, 49.49671, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_paderborn_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paderborn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.75439, 51.71905, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_duisburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Duisburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.76516, 51.43247, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_krefeld_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Krefeld'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.58615, 51.33921, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_siegen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siegen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.02431, 50.87481, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_chemnitz_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chemnitz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.92922, 50.8357, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_münster_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Münster'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.62571, 51.96236, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_dresden_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dresden'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.73832, 51.05089, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_hamburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hamburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.01534, 53.57532, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_mainz_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mainz'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.2791, 49.98419, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_neuss_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Neuss'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.68504, 51.19807, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_reutlingen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reutlingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.20427, 48.49144, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_würzburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Würzburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95121, 49.79391, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_leverkusen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leverkusen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.98432, 51.0303, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_rostock_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rostock'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.14049, 54.0887, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_solingen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Solingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.0845, 51.17343, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_pforzheim_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pforzheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.69892, 48.88436, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_bonn_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bonn'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.09549, 50.73438, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_oldenburg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oldenburg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.21467, 53.14118, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_wuppertal_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wuppertal'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.16755, 51.27027, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_potsdam_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potsdam'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.06566, 52.39886, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_nuremberg_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nuremberg'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.07752, 49.45421, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_cologne_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cologne'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.95, 50.93333, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_mulheim_an_der_ruhr_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mülheim an der Ruhr'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(6.88333, 51.43333, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_hanover_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hanover'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.73322, 52.37052, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_ludwigshafen_am_rhein_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ludwigshafen am Rhein'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.44641, 49.48121, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_cottbus_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cottbus'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.32888, 51.75769, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_erlangen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Erlangen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.00783, 49.59099, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_hildesheim_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hildesheim'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.95112, 52.15077, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_jena_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jena'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5899, 50.92878, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_göttingen_deu() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Göttingen'], 'DEU')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.93228, 51.53443, 4326)::geography,3000)::geometry, 4326))" should true

}

    # Italy tests - 2km of tolerance for the city point with country

function test_geocoding_functions_namedplace_pescara_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pescara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20283, 42.4584, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_acerra_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acerra'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.37261, 40.94744, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_acireale_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acireale'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.16325, 37.62606, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_afragola_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Afragola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.31323, 40.9242, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_agrigento_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agrigento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.59351, 37.32744, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_alessandria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alessandria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.61007, 44.90924, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_altamura_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altamura'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.54952, 40.82664, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ancona_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ancona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.50337, 43.5942, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_andria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.29797, 41.23117, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_anzio_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Anzio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.61883, 41.48493, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_aprilia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aprilia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.65729, 41.58808, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_arezzo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arezzo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.86867, 43.44708, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ascoli_piceno_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ascoli Piceno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.60658, 42.85185, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_asti_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Asti'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.20751, 44.90162, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_avellino_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avellino'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79652, 40.92033, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_aversa_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aversa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.20745, 40.97259, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bagheria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bagheria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.51237, 38.07892, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bari_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.8554, 41.11148, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_barletta_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barletta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.28165, 41.31429, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_battipaglia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Battipaglia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.9876, 40.6045, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_siena_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Siena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.3259, 43.32215, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_benevento_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benevento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.78101, 41.1256, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bergamo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bergamo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.66721, 45.69601, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bisceglie_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bisceglie'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.49492, 41.24106, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bitonto_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bitonto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.69086, 41.11006, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bologna_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bologna'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33875, 44.49381, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_bolzano_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bolzano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.33982, 46.49067, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_brescia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brescia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.21472, 45.53558, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_brindisi_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brindisi'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.93607, 40.63215, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_busto_arsizio_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Busto Arsizio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.84914, 45.61128, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_caltanissetta_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caltanissetta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.05163, 37.48997, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_campobasso_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Campobasso'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.66737, 41.55947, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_carpi_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carpi'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.39472, 45.1356, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_carrara_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carrara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.06049, 44.05405, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_casalnuovo_di_napoli_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casalnuovo di Napoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34993, 40.90834, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_caserta_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Caserta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.34002, 41.07619, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cava_de_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cava de'' Tirreni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70564, 40.70091, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_l’aquila_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['L’Aquila'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.39954, 42.35055, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_casoria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Casoria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.29363, 40.90906, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_castellammare_di_stabia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellammare di Stabia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.48685, 40.70211, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_catania_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catania'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.07041, 37.49223, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_catanzaro_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catanzaro'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.60086, 38.88247, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cerignola_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cerignola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.8998, 41.26383, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cesena_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cesena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.24315, 44.1391, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_chieti_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chieti'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.16163, 42.35296, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_chioggia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chioggia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.27774, 45.21857, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cinisello_balsamo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cinisello Balsamo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.22104, 45.55646, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_civitavecchia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Civitavecchia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79674, 42.09325, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_collegno_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Collegno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.57832, 45.07919, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_como_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Como'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.08065, 45.80079, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cosenza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cosenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.25201, 39.30422, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cremona_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cremona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.02297, 45.14047, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_crotone_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crotone'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.10997, 39.0823, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cuneo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuneo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.54828, 44.39071, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ercolano_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ercolano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.36382, 40.8138, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_faenza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Faenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.88334, 44.2857, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_fano_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.01665, 43.84052, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ferrara_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.60868, 44.84346, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_fiumicino_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fiumicino'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.68488, 45.89938, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_florence_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Florence'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.24626, 43.77925, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_foggia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foggia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55188, 41.45845, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_foligno_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Foligno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.70664, 42.95324, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_forlì_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Forlì'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.05245, 44.22054, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_gallarate_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gallarate'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.79164, 45.66019, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_gela_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gela'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.23704, 37.0757, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_genoa_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Genoa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91519, 44.4264, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_giugliano_in_campania_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Giugliano in Campania'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.19557, 40.93188, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_grosseto_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Grosseto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.10955, 42.76871, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_guidonia_montecelio_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guidonia Montecelio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.72238, 41.99362, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_imola_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Imola'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.7132, 44.35916, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_lamezia_terme_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lamezia Terme'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.3092, 38.96589, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_la_spezia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Spezia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.83632, 44.11096, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_latina_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Latina'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.9043, 41.46614, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_lecce_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lecce'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(18.17244, 40.35481, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_legnano_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Legnano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.91355, 45.5947, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_livorno_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Livorno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32615, 43.54427, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_lucca_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucca'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.47234, 43.8497, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_manfredonia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manfredonia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.91038, 41.62746, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_marano_di_napoli_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marano di Napoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.17476, 40.89601, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_marsala_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marsala'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.4983, 37.86736, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_massa_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Massa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.11869, 44.02079, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_matera_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Matera'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59723, 40.66983, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_mazara_del_vallo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazara del Vallo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.59304, 37.65418, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_messina_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Messina'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.55256, 38.19394, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_milan_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Milan'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.17278, 45.59282, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_modena_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92539, 44.64783, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_modica_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Modica'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.76976, 36.8499, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_molfetta_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Molfetta'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.59503, 41.19695, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_moncalieri_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncalieri'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.69202, 45.0031, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_monza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.27246, 45.58005, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_novara_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novara'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.62328, 45.44834, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_olbia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olbia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.50395, 40.92334, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_palermo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palermo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.33561, 38.13205, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_parma_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parma'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.32618, 44.79935, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pavia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pavia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.15917, 45.19205, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_perugia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Perugia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.38878, 43.1122, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pesaro_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pesaro'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.895, 43.90121, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_piacenza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Piacenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.70462, 45.04202, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pisa_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pisa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.4036, 43.70853, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pistoia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pistoia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.92365, 43.93064, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pomezia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pomezia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.50015, 41.66369, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pordenone_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pordenone'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.66051, 45.95689, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_portici_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portici'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.33716, 40.81563, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_potenza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Potenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.80794, 40.64175, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_pozzuoli_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozzuoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.15321, 40.82767, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_prato_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Prato'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.08278, 43.87309, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_quartu_sant_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Quartu Sant''Elena'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.25004, 39.22935, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ragusa_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ragusa'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.70689, 36.89639, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_ravenna_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ravenna'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.20121, 44.41344, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_reggio_calabria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Calabria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.66129, 38.11047, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_rho_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rho'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.05182, 45.52812, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_rimini_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rimini'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.56528, 44.05755, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_rome_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rome'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.51133, 41.89193, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_rovigo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rovigo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.79109, 45.07387, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_salerno_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salerno'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.79328, 40.67545, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_san_severo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Severo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.38148, 41.68564, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_sassari_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sassari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.55037, 40.72787, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_savona_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Savona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.47715, 44.30905, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_scafati_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scafati'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52919, 40.75766, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_scandicci_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Scandicci'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.18794, 43.75423, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_sesto_san_giovanni_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sesto San Giovanni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.23401, 45.53449, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_taranto_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Taranto'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(17.25478, 40.41639, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_teramo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teramo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.69901, 42.66123, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_terni_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Terni'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.63667, 42.56184, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_tivoli_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tivoli'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.80317, 41.95781, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_torre_del_greco_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torre del Greco'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.39782, 40.77939, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_trani_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trani'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(16.41011, 41.27733, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_trapani_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trapani'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.54127, 38.01391, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_trento_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trento'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.12108, 46.06787, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_treviso_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Treviso'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.23614, 45.66908, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_trieste_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Trieste'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.7903, 45.64325, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_turin_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Turin'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.68682, 45.07049, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_udine_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Udine'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(13.24458, 46.0637, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_varese_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Varese'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.82223, 45.81934, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_velletri_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Velletri'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.78103, 41.66784, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_venice_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Venice'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.33265, 45.43713, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_verona_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Verona'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.98444, 45.4299, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_viareggio_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viareggio'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.25581, 43.87145, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_vicenza_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vicenza'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.5475, 45.54672, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_vigevano_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigevano'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(8.85437, 45.31407, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_viterbo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viterbo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(12.11141, 42.42322, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_vittoria_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vittoria'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.52788, 36.95151, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_naples_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Naples'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(14.24641, 40.85631, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_padua_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Padua'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(11.88586, 45.40797, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_reggio_emilia_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reggio Emilia'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(10.63125, 44.69825, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_sanremo_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanremo'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(7.7772, 43.81725, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_syracuse_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Syracuse'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(15.27628, 37.08415, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

function test_geocoding_functions_namedplace_cagliari_ita() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cagliari'], 'ITA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(9.11917, 39.23054, 4326)::geography,3000)::geometry, 4326))" should true 
 
}

    # Spain tests - 2km of tolerance for the city point with country

 function test_geocoding_functions_namedplace_laspalmasdegrancanaria_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Palmas de Gran Canaria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41343, 28.09973, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santaperpetuademoguda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Perpetua de Moguda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.18333, 41.53333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanvicentedelraspeig_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Vicente del Raspeig'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5255, 38.3964, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vendrell_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vendrell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.53333, 41.21667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villafrancadelpanadés_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villafranca del Panadés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.7, 41.35, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vinaroz_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vinaroz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.47559, 40.47033, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_zarauz_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zarauz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.16992, 43.28444, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcira_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcira'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43333, 39.15, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcobendas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcobendas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.64197, 40.54746, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcorcón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcorcón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.82487, 40.34582, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcoy_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcoy'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.47432, 38.70545, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_algeciras_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Algeciras'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.45051, 36.13326, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alicante_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alicante'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.48149, 38.34517, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_almería_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almería'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45974, 36.83814, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_almonte_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almonte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.51667, 37.2647, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_almuñécar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almuñécar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69072, 36.73393, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_altea_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Altea'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.05139, 38.59885, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_amposta_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Amposta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.58103, 40.71308, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_andújar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Andújar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.05077, 38.03922, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_antequera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Antequera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56123, 37.01938, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_arandadeduero_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranda de Duero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.6892, 41.67041, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_aranjuez_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aranjuez'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60246, 40.03108, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_arcosdelafrontera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arcos de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.81056, 36.75075, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_arona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.68102, 28.09962, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_arrecife_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Arrecife'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.54769, 28.96302, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ávila_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ávila'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.69951, 40.65724, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_avilés_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Avilés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92483, 43.55473, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ayamonte_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ayamonte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.40266, 37.20994, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_badajoz_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badajoz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.97061, 38.87789, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_badalona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Badalona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.24741, 41.45004, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_baracaldo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baracaldo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.99729, 43.29564, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_barcelona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barcelona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.15899, 41.38879, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_basauri_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Basauri'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.8858, 43.2397, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_benalmádena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benalmádena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.56937, 36.59548, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_benicarló_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benicarló'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.42709, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_benidorm_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Benidorm'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.13098, 38.53816, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bilbao_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bilbao'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.92528, 43.26271, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_blanes_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blanes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79036, 41.67419, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_boadilladelmonte_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boadilla del Monte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87835, 40.405, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_burgos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burgos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67527, 42.35022, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_burriana_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Burriana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08499, 39.88901, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cáceres_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cáceres'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.37224, 39.47649, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cádiz_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cádiz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.29465, 36.52978, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_calafell_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calafell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.5683, 41.19997, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_calatayud_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calatayud'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64318, 41.35353, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_calpe_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calpe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.0445, 38.6447, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_camas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Camas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.03314, 37.40202, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_campello_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Campello'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.09855, 40.51519, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_candelaria_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Candelaria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.37268, 28.3548, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_carcaixent_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carcaixent'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44812, 39.1218, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_carmona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Carmona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.64608, 37.47125, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cartagena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cartagena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.98623, 37.60512, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cártama_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cártama'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63297, 36.71068, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_castrourdiales_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castro-Urdiales'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.22043, 43.38285, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_catarroja_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Catarroja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4, 39.4, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ceuta_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ceuta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.31979, 35.88933, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_chiclanadelafrontera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chiclana de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.14941, 36.41915, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ciempozuelos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciempozuelos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.62103, 40.15913, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cieza_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cieza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.41987, 38.23998, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ciudadreal_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ciudad Real'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92907, 38.98626, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_coín_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coín'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.75639, 36.65947, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_colmenarviejo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colmenar Viejo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76762, 40.65909, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_conildelafrontera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Conil de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0885, 36.27719, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_córdoba_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Córdoba'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.77275, 37.89155, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_coriadelrío_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coria del Río'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.0541, 37.28766, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_coslada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coslada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.56129, 40.42378, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_crevillente_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crevillente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.80975, 38.24994, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cuenca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cuenca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.13333, 40.06667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cullera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cullera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.16667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_denia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.10574, 38.84078, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_doshermanas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dos Hermanas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92088, 37.28287, 4326)::geography,3000)::geometry, 4326))" should true

}

function test_geocoding_functions_namedplace_durango_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Durango'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.6338, 43.17124, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_écija_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Écija'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.0826, 37.5422, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elche_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elche'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.70107, 38.26218, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Elda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79157, 38.47783, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elejido_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Ejido'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.81456, 36.77629, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elmasnou_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Masnou'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.3188, 41.47978, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elpratdellobregat_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Prat de Llobregat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.09472, 41.32784, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elpuertodesantamaría_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Puerto de Santa María'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.23298, 36.59389, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_estepona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Estepona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.14589, 36.42764, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ferrol_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ferrol'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.23689, 43.48321, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_figueras_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Figueras'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.02559, 43.53943, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_fuengirola_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuengirola'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.62473, 36.53998, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_fuenlabrada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fuenlabrada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79415, 40.28419, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_galapagar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galapagar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.00426, 40.5783, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_gerona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gerona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.82493, 41.98311, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_getafe_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Getafe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.73295, 40.30571, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_gijón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gijón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66152, 43.53573, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_granada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.60667, 37.18817, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_granollers_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Granollers'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28773, 41.60797, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guadalajara_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.16185, 40.62862, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guadix_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadix'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.13922, 37.29932, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_huelva_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huelva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.94004, 37.26638, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_huesca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huesca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.4087, 42.13615, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ibi_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibi'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.57225, 38.62533, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ibiza_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ibiza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.43296, 38.90883, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_igualada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Igualada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.6172, 41.58098, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_illescas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Illescas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.84704, 40.12213, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_inca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Inca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.91093, 39.7211, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_jaén_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jaén'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.79028, 37.76922, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_jerezdelafrontera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jerez de la Frontera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.13606, 36.68645, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_jumilla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jumilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.325, 38.47917, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lagunadeduero_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Laguna de Duero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72332, 41.58151, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lalíneadelaconcepción_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Línea de la Concepción'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.34777, 36.16809, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_laoliva_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Oliva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.92912, 28.61052, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_laorotava_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Orotava'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.52309, 28.39076, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_larinconada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Rinconada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.98091, 37.48613, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lasrozasdemadrid_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Rozas de Madrid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87371, 40.49292, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lastorresdecotillas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Torres de Cotillas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.24188, 38.02822, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lebrija_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lebrija'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.07529, 36.92077, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_leganés_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leganés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.7635, 40.32718, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_león_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['León'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.57032, 42.60003, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lepe_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lepe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.20433, 37.25482, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lérida_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lérida'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.62556, 41.61389, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_linares_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Linares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.63602, 38.09519, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_liria_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Liria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.59783, 39.62894, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lloretdemar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lloret de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.84565, 41.69993, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_logroño_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Logroño'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.45, 42.46667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_loja_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Loja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.15129, 37.16887, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lorca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lorca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.7017, 37.67119, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_losbarrios_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Barrios'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.49213, 36.18482, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_losrealejos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Realejos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.58335, 28.36739, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lucena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lucena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.48522, 37.40881, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lugo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lugo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.55602, 43.00992, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_madrid_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Madrid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70256, 40.4165, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mairenadelalcor_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Alcor'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.74951, 37.37301, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mairenadelaljarafe_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mairena del Aljarafe'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.06391, 37.34461, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_majadahonda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Majadahonda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.87182, 40.47353, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_málaga_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Málaga'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.42034, 36.72016, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_manacor_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manacor'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.20955, 39.56964, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_manises_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manises'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46349, 39.49139, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_manlleu_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manlleu'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.28476, 42.00228, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_manresa_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manresa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.82656, 41.72498, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_marbella_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Marbella'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.88583, 36.51543, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_martorell_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martorell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.93062, 41.47402, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_martos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Martos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.97264, 37.72107, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mataró_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mataró'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.4445, 41.54211, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mazarrón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mazarrón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.31493, 37.5992, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_medinadelcampo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Medina del Campo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.91413, 41.31239, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mejoradadelcampo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mejorada del Campo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.48194, 40.39283, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_melilla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Melilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.93833, 35.29369, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mérida_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mérida'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.34366, 38.91611, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mieres_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mieres'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.76667, 43.25, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mijas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mijas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63728, 36.59575, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mirandadeebro_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Miranda de Ebro'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.94695, 42.6865, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mislata_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mislata'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41825, 39.47523, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_moncada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Moncada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.39551, 39.54555, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mondragón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mondragón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.48977, 43.06441, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_montilla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.63805, 37.58627, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_móstoles_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Móstoles'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.86496, 40.32234, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_muchamiel_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Muchamiel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.44529, 38.4158, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_murcia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Murcia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.13004, 37.98704, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_navalcarnero_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Navalcarnero'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.01197, 40.28908, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_nerja_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nerja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.8744, 36.75278, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_níjar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Níjar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.20595, 36.96655, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_novelda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Novelda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.76773, 38.38479, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_oliva_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oliva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11935, 38.91971, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_olot_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Olot'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.49012, 42.18096, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_onda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.25, 39.96667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_orense_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orense'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.86407, 42.33669, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_orihuela_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Orihuela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.94401, 38.08483, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_oviedo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oviedo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.84476, 43.36029, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_paiporta_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paiporta'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41667, 39.43333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_palafrugell_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palafrugell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(3.1631, 41.91738, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_palencia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.52406, 42.00955, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_palmadelrío_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palma del Río'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.28121, 37.70024, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_palmademallorca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Palma de Mallorca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.65024, 39.56939, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pamplona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pamplona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.64323, 42.81687, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_paracuellosdejarama_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paracuellos de Jarama'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.52775, 40.50353, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_parla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Parla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.76752, 40.23604, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_paterna_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Paterna'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.43333, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_petrel_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Petrel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.77549, 38.48289, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pilardelahoradada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pilar de la Horadada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79256, 37.86591, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pinedademar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pineda de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.6889, 41.62763, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pinto_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pinto'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.69999, 40.24147, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_plasencia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Plasencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.08845, 40.03116, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ponferrada_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ponferrada'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.59619, 42.54664, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pontevedra_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pontevedra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.64435, 42.431, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_portugalete_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portugalete'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02064, 43.32099, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_pozuelodealarcón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Pozuelo de Alarcón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.81338, 40.43293, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_puertollano_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puertollano'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10734, 38.68712, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_puertoreal_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puerto Real'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.19011, 36.52819, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_redondela_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Redondela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.6096, 42.28337, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_requena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Requena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10044, 39.48834, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_reus_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reus'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.10687, 41.15612, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ronda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ronda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.16709, 36.74231, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_roquetasdemar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Roquetas de Mar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.61475, 36.76419, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_rota_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rota'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3622, 36.62545, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_rubí_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rubí'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.03305, 41.49226, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sabadell_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sabadell'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10942, 41.54329, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sagunto_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sagunto'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.26667, 39.68333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_salamanca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salamanca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.66388, 40.96882, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_salou_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salou'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.14163, 41.07663, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_salt_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Salt'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.79281, 41.97489, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanfernando_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.19817, 36.4759, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanfernandodehenares_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Fernando de Henares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.53261, 40.42386, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanjavier_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Javier'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.83736, 37.80626, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanjosé_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San José'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.10912, 36.76048, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanlúcardebarrameda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sanlúcar de Barrameda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.3515, 36.77808, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanpedrodelpinatar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Pedro del Pinatar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.79102, 37.83568, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanroque_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Roque'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.38415, 36.21067, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sansebastiándelosreyes_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Sebastián de los Reyes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.61588, 40.54433, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santacruzdetenerife_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Cruz de Tenerife'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.25462, 28.46824, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santander_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santander'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.80444, 43.46472, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santapola_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santa Pola'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.5658, 38.19165, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santiagodecompostela_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santiago de Compostela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.54569, 42.88052, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_santurce_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Santurce'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.03248, 43.32842, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_segovia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Segovia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.11839, 40.94808, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sestao_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sestao'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.00716, 43.30975, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sevilla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sevilla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.97317, 37.38283, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sitges_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sitges'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.81193, 41.23506, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_soria_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Soria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.46883, 41.76401, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sueca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sueca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.31114, 39.2026, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tacoronte_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tacoronte'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.41016, 28.47688, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_talaveradelareina_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Talavera de la Reina'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.83076, 39.96348, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tarragona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tarragona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.25, 41.11667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_teguise_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teguise'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.56397, 29.06049, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_telde_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Telde'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.41915, 27.99243, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_teruel_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Teruel'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.10646, 40.3456, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tías_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tías'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-13.64502, 28.96108, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_toledo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toledo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.02263, 39.8581, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tomares_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-6.04589, 37.37281, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tomelloso_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tomelloso'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02156, 39.15759, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torrejóndeardoz_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrejón de Ardoz'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.46973, 40.45535, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torrelavega_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelavega'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.04785, 43.34943, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torrelodones_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrelodones'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.92658, 40.57654, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torremolinos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torremolinos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.49976, 36.62035, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torrente_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46546, 39.43705, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torrevieja_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torrevieja'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.68222, 37.97872, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tortosa_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tortosa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.5216, 40.81249, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_totana_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Totana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.50229, 37.7688, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_trescantos_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tres Cantos'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.70806, 40.60092, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tudela_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tudela'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.60452, 42.06166, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_úbeda_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Úbeda'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.3705, 38.01328, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_utrera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Utrera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.78093, 37.18516, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_valdemoro_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdemoro'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.67887, 40.19081, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_valdepeñas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valdepeñas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.38483, 38.76211, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_valencia_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valencia'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.37739, 39.46975, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_valladolid_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valladolid'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.72372, 41.65518, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_valls_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Valls'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.24993, 41.28612, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vélezmálaga_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vélez-Málaga'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.10045, 36.77262, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vícar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vícar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.64273, 36.83155, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vic_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vic'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25486, 41.93012, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vigo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vigo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.72264, 42.23282, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_viladecans_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Viladecans'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.01427, 41.31405, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vilaseca_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vilaseca'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.25528, 42.06174, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villajoyosa_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villajoyosa'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.23346, 38.50754, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villanuevadelaserena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villanueva de la Serena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.7974, 38.97655, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villarreal_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarreal'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-7.21533, 38.72572, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villarrobledo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villarrobledo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.60119, 39.26992, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villaviciosadeodón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villaviciosa de Odón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.90011, 40.35692, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_villena_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Villena'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.86568, 38.6373, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vitoria_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vitoria'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.67268, 42.84998, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_yecla_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Yecla'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.11468, 38.61365, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_zamora_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zamora'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.74456, 41.50633, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_zaragoza_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Zaragoza'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.87734, 41.65606, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alacuás_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alacuás'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.461, 39.45568, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcaládeguadaíra_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Guadaíra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.83951, 37.33791, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_aldaya_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Aldaya'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.46005, 39.46569, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_almazora_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Almazora'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.06313, 39.94729, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_barbate_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barbate'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.92186, 36.19237, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_calviá_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calviá'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.50621, 39.5657, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_castellóndelaplana_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Castellón de la Plana'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.03333, 39.98333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_éibar_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Éibar'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.47158, 43.18493, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_esparraguera_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Esparraguera'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.87025, 41.53809, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_galdácano_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Galdácano'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.83333, 43.23333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_gandía_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gandía'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.18333, 38.96667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guecho_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guecho'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.01146, 43.35689, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_hospitaletdellobregat_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hospitalet de Llobregat'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.10028, 41.35967, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_irún_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Irún'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78938, 43.33904, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_játiva_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Játiva'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.51852, 38.99042, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_jávea_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jávea'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.16667, 38.78333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lacoruña_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['La Coruña'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-8.396, 43.37135, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_langreo_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Langreo'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-5.68416, 43.29568, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lejona_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lejona'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.98333, 43.33333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mahón_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mahón'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(4.26583, 39.88853, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_molletdelvallés_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mollet del Vallés'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(2.21306, 41.54026, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_onteniente_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Onteniente'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.60603, 38.82191, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_picasent_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Picasent'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45949, 39.3635, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_puentegenil_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puente Genil'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.76686, 37.38943, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_adeje_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adeje'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-16.726, 28.12271, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_adra_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Adra'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.02055, 36.74961, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_águilas_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Águilas'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.58289, 37.4063, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_agüimes_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Agüimes'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-15.44609, 27.90539, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_albacete_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Albacete'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.85643, 38.99424, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alboraya_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alboraya'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.35, 39.5, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_alcaládehenares_esp() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Alcalá de Henares'], 'ESP')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.35996, 40.48205, 4326)::geography,3000)::geometry, 4326))" should true
 
}


    # North America tests - 2km of tolerance for the city point with country

function test_geocoding_functions_namedplace_portland_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portland'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.67621, 45.52345, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_philadelphia_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Philadelphia'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.16379, 39.95233, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_chihuahua_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chihuahua'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.08889, 28.63528, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_baltimore_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Baltimore'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.61219, 39.29038, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_columbus_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Columbus'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.99879, 39.96118, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guadalupe_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalupe'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.25646, 25.67678, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_newyork_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['New York'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-74.0060, 40.7143, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanfrancisco_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Francisco'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.41942, 37.77493, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mississauga_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mississauga'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.6583, 43.5789, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_saltillo_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Saltillo'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.0053, 25.42321, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_portauprince_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Port-au-Prince'], 'Haiti')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-72.335, 18.53917, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_monterrey_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Monterrey'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.31847, 25.67507, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_austin_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Austin'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.74306, 30.26715, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_louisville_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Louisville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-85.75941, 38.25424, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_seattle_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Seattle'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-122.33207, 47.60621, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_chicago_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chicago'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.65005, 41.85003, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_memphis_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Memphis'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.04898, 35.14953, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_dallas_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dallas'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.80667, 32.78306, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_havana_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havana'], 'Cuba')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-82.38304, 23.13302, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_calgary_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Calgary'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-114.08529, 51.05011, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_oklahomacity_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oklahoma City'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.51643, 35.46756, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_puebla_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Puebla'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.20193, 19.04334, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guatemalacity_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guatemala City'], 'Guatemala')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-90.51327, 14.64072, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lasvegas_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Las Vegas'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.13722, 36.17497, 4326)::geography,10000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_detroit_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Detroit'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-83.04575, 42.33143, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_hermosillo_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hermosillo'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-110.97732, 29.1026, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_managua_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Managua'], 'Nicaragua')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.2504, 12.13282, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mérida_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mérida'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-89.61696, 20.97537, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_juárez_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Juárez'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.09582, 25.64724, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_edmonton_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Edmonton'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.46871, 53.55014, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_morelia_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Morelia'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.18443, 19.70078, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanluispotosí_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Luis Potosí'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-100.97916, 22.14982, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_houston_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Houston'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-95.36327, 29.76328, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sanjose_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Jose'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-121.89496, 37.33939, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_león_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['León'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-101.671, 21.13052, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mexicali_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexicali'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-115.45446, 32.62781, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_charlotte_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Charlotte'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-80.84313, 35.22709, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sandiego_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['San Diego'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.15726, 32.71533, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_phoenix_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Phoenix'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-112.07404, 33.44838, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_elpaso_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['El Paso'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-106.48693, 31.75872, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tegucigalpa_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tegucigalpa'], 'Honduras')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-87.20681, 14.0818, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_guadalajara_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Guadalajara'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.39182, 20.66682, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_denver_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Denver'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-104.9847, 39.73915, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_acapulco_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Acapulco'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-91.51028, 16.11417, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ottawa_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ottawa'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-75.69812, 45.41117, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_fortworth_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Fort Worth'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.32085, 32.72541, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_boston_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Boston'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-71.05977, 42.35843, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_mexicocity_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Mexico City'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.12766, 19.42847, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tijuana_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tijuana'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-117.00371, 32.5027, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_nashville_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nashville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.78444, 36.16589, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_jacksonville_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Jacksonville'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-81.65565, 30.33218, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cancún_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cancún'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.84656, 21.17429, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_losangeles_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Los Angeles'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-118.24368, 34.05223, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_indianapolis_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Indianapolis'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-86.15804, 39.76838, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_montreal_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Montreal'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-73.58781, 45.50884, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_kingston_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston'], 'Jamaica')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-76.79358, 17.99702, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_torreón_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Torreón'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-96.38611, 18.41194, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_vancouver_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Vancouver'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-123.11934, 49.24966, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_washington_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Washington'], 'USA')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-113.50829, 37.13054, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_toronto_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Toronto'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-79.4163, 43.70011, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_winnipeg_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Winnipeg'], 'Canada')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-97.14704, 49.8844, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tlaquepaque_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlaquepaque'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-103.29327, 20.64091, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_tlalnepantla_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Tlalnepantla'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.19538, 19.54005, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ecatepecdemorelos_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ecatepec de Morelos'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.06601, 19.61725, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_chimalhuacán_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chimalhuacán'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-98.95038, 19.42155, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_naucalpan_na() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Naucalpan'], 'Mexico')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-99.23963, 19.47851, 4326)::geography,3000)::geometry, 4326))" should true
 
}


    # England tests - 2km of tolerance for the city point without country

function test_geocoding_functions_namedplace_barnet_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Barnet'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2, 51.65, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bexley_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bexley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.14866, 51.44162, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_birmingham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Birmingham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.89983, 52.48142, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_blackburn_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blackburn'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.48333, 53.75, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_blackpool_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Blackpool'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.05, 53.81667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bolton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bolton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.43333, 53.58333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bournemouth_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bournemouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.8795, 50.72048, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bradford_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bradford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.75206, 53.79391, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_brent_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brent'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.3023, 51.55306, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_brighton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Brighton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.13947, 50.82838, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bristol_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bristol'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.59665, 51.45523, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_bromley_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Bromley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.01519, 51.40606, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_cambridge_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Cambridge'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.11667, 52.2, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_chesterfield_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Chesterfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.41667, 53.25, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_colchester_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Colchester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.90421, 51.88921, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_coventry_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Coventry'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.51217, 52.40656, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_crawley_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Crawley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.18312, 51.11303, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_derby_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Derby'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.47663, 52.92277, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_dudley_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Dudley'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.08333, 52.5, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ealing_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ealing'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.30204, 51.51216, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_eastbourne_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Eastbourne'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.28453, 50.76871, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_enfield_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Enfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08497, 51.65147, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_exeter_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Exeter'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-3.52751, 50.7236, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_gloucester_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Gloucester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.2431, 51.86568, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_greenwich_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Greenwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.01176, 51.47785, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_hackney_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hackney'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.05, 51.55, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_haringey_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Haringey'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08333, 51.58333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_harrow_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Harrow'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.33208, 51.57835, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_hillingdon_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hillingdon'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.45293, 51.53291, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_hounslow_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Hounslow'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.36092, 51.46839, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_huddersfield_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Huddersfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78416, 53.64904, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_ipswich_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Ipswich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.15545, 52.05917, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_islington_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Islington'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.10304, 51.53622, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_kingstonuponthames_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston upon Thames'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2974, 51.41259, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lambeth_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lambeth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11152, 51.49635, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_richmonduponthames_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Richmond upon Thames'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.30212, 51.45689, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_leeds_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leeds'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.54785, 53.79648, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_leicester_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Leicester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.13169, 52.6386, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_lewisham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Lewisham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.01193, 51.46431, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_liverpool_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Liverpool'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.97794, 53.41058, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_luton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Luton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.41748, 51.87967, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_manchester_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Manchester'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.23743, 53.48095, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_merton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Merton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.1, 50.88333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_middlesbrough_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Middlesbrough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.23483, 54.57623, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_newcastleupontyne_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Newcastle upon Tyne'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.61396, 54.97328, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_newham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Newham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.71667, 55.53333, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_northampton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Northampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.88333, 52.25, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_norwich_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Norwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(1.29834, 52.62783, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_nottingham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Nottingham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.15047, 52.9536, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_oldham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oldham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.1183, 53.54051, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_oxford_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Oxford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.25596, 51.75222, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_peterborough_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Peterborough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.24777, 52.57364, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_plymouth_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Plymouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-4.14305, 50.37153, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_poole_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Poole'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2, 50.71667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_portsmouth_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Portsmouth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.09125, 50.79899, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_preston_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Preston'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.71667, 53.76667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_reading_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Reading'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.97113, 51.45625, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_redbridge_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Redbridge'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.46667, 50.91667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_rotherham_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Rotherham'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.35678, 53.43012, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sheffield_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sheffield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.4659, 53.38297, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_slough_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Slough'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.59541, 51.50949, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_southampton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.40428, 50.90395, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_southendonsea_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southend-on-Sea'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.71433, 51.53782, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_southwark_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Southwark'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.08333, 51.5, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sthelens_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['St Helens'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.73333, 53.45, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_stockport_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stockport'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.15761, 53.40979, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_stokeontrent_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Stoke-on-Trent'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.18538, 53.00415, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sunderland_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sunderland'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.38222, 54.90465, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_sutton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sutton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.2, 51.35, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_suttoncoldfield_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Sutton Coldfield'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.81667, 52.56667, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_swindon_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Swindon'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.78116, 51.55797, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_walsall_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Walsall'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.98396, 52.58528, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_wandsworth_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wandsworth'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.20784, 51.4577, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_watford_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Watford'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.39602, 51.65531, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_westbromwich_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['West Bromwich'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.9945, 52.51868, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_wolverhampton_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Wolverhampton'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-2.12296, 52.58547, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_york_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['York'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-1.08271, 53.95763, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_havering_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Havering'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(0.18608, 51.61557, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_kingstonuponhull_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Kingston upon Hull'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.33525, 53.7446, 4326)::geography,3000)::geometry, 4326))" should true
 
}

function test_geocoding_functions_namedplace_westminster_gbr() {

    sql "SELECT ST_Intersects((geocode_namedplace(Array['Westminster'], 'GBR')).geom, ST_SetSRID(ST_Buffer(ST_MakePoint(-0.11667, 51.5, 4326)::geography,3000)::geometry, 4326))" should true
 
}



#################################################### TESTS END HERE ####################################################
