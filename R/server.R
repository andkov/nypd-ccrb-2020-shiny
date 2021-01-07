#'
#' @import shiny
#' @import dplyr
#' @import leaflet
#' @import sf
#' @importFrom stringr str_detect
#' @importFrom shinyjs html

# TODO: Clean up @imports

# ---- server ------------------------------------------------------------------

app_server <- function(input,output,session){
  precinct_summary <- reactive({

    map_click <- input$precinct_map_shape_click

    if(is.null(map_click)){
      precinct_filter <- 1
    } else {
      precinct_filter <- map_click$id
    }

    create_precinct_summary(allegations, precinct_filter = precinct_filter)
  })


  output$allegations_info <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      title = "Allegations"
      ,value = precinct_summary()$allegations
      ,icon = icon("crosshairs")
      ,color = "blue"
    )
  })

  output$complaint_info <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      title = "Complaints"
      ,value = precinct_summary()$complaints
      ,icon = icon("crosshairs")
      ,color = "blue"
    )
  })

  output$officers_complaint_info <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      title = "Officers with Complaints"
      ,value = precinct_summary()$officers_with_complaints
      ,icon = icon("user")
      ,color = "blue"
    )
  })

  output$precinct_map <- leaflet::renderLeaflet({
    leaflet::leaflet(data = precinct_map) %>%
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
  })


  output$map_text <- renderText({

    click <- input$precinct_map_shape_click

    if(is.null(click)){
      return("Nothing Clicked")
    }

    text <- paste0("Clicked : ", click$id)

    return(text)

  })


  observeEvent(input$precinct_map_shape_click, {

    click <- input$precinct_map_shape_click

    shinyjs::html(id = "title_placeholder", html = paste0("Precinct:", click$id))


  })


}




