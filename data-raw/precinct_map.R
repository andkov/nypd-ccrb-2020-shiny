## Code to prepare `precinct_map` dataset



path_geojson <- "./data-raw/police_precincts.geojson"

precinct_map <- geojsonsf::geojson_sf(path_geojson)



usethis::use_data(precinct_map, overwrite = TRUE)
