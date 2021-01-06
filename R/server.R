#'
#' @import shiny
#' @import dplyr
#' @import leaflet
#' @import sf
#' @importFrom stringr str_detect
#' @importfrom readr read_csv
#' @importFrom shinyjs html

# TODO: Clean up @imports

# ---- server ------------------------------------------------------------------

app_server <- function(input,output,session){
  precinct_summary <- reactive({

    map_click <- input$precinct_map_shape_click

    if(is.null(map_click)){
      precicnt_filter <- 1
    } else {
      precicnt_filter <- map_click$id
    }
    #TODO: Move to function file
    allegations %>% filter(precinct == precicnt_filter) %>%
      summarise(
        allegations = n()
        ,complaints = n_distinct(complaint_id)
        ,substantiated = sum(str_detect(board_disposition,"Substantiated"))
        ,exonerated = sum(str_detect(board_disposition,"Exonerated"))
        ,unsubstantiated  = sum(str_detect(board_disposition,"Unsubstantiated"))
        ,officers_with_complaints = n_distinct(first_name,last_name)
      )
  })


  output$allegations_info <- renderInfoBox({
    infoBox(
      title = "Allegations"
      ,value = precinct_summary()$allegations
      ,icon = icon("crosshairs")
      ,color = "blue"
    )
  })

  output$complaint_info <- renderInfoBox({
    infoBox(
      title = "Complaints"
      ,value = precinct_summary()$complaints
      ,icon = icon("crosshairs")
      ,color = "blue"
    )
  })

  output$officers_complaint_info <- renderInfoBox({
    infoBox(
      title = "Officers with Complaints"
      ,value = precinct_summary()$officers_with_complaints
      ,icon = icon("user")
      ,color = "blue"
    )
  })

  output$precinct_map <- renderLeaflet({
    leaflet(data = precinct_map) %>%
      addTiles() %>%
      addPolygons(
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




