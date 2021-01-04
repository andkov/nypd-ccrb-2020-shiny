
nypd_sf_package <- geojsonsf::geojson_sf("./data-unshared/raw/policeprecincts.geojson")


# --- leaflet ----
# use for shiny

library(leaflet)

map_leaf <- leaflet(data =  nypd_sf) %>%
  addTiles() %>%
  addPolygons(color = "Black")

map_leaf



map_sf_package <- leaflet(data =  nypd_sf_package) %>%
  addTiles() %>%
  addPolygons(color = "black", highlightOptions = highlightOptions(color = "white", weight = 2,
              bringToFront = TRUE),label = ~glue::glue("This is: {precinct}"))

map_sf_package
# see leaflet doc for explanation

pal <- colorNumeric(
  palette = "Blues"
  ,domain = ds1$n
  ,na.color = NA
)

map_sf_package_color <- leaflet(data =  merge_data) %>%
  addTiles() %>%
  addPolygons(
    color = "black"
    ,weight = 1
    ,fillOpacity = 0.8
    ,fillColor = ~pal(n)
    ,highlightOptions = highlightOptions(
      color = "white"
      ,weight = 2
      ,bringToFront = TRUE
      )
    ,label = ~glue::glue(
      "This is: {precinct}",
      "They had {n} complaints" ))

map_sf_package_color
