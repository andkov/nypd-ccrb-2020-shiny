#' Create Precinct Map
#'
#' @param d A geojson file
#'
#' @return
#' @export
#'
#' @examples
create_precinct_map <- function(d){
  leaflet::leaflet(data = d) %>%
    leaflet::addTiles() %>%
    leaflet::addPolygons(
      color = "black"
      ,weight = 1
      ,fillOpacity = 0.2
      ,highlightOptions = highlightOptions(
        color = "white"
        ,weight = 2
        ,bringToFront = TRUE
      )
      ,label = ~glue::glue(
        "Precinct: {precinct}"
      )
      ,layerId = ~precinct
    )
}










