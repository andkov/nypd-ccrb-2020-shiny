rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run.
cat("\f") # clear console when working in RStudio


# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ---- load-libraies -----------------------------------------------------------
library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"

path_geojson <- "./data-unshared/raw/police_precincts.geojson"

# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)

precinct_map <- geojsonsf::geojson_sf(path_geojson)


# ---- server ------------------------------------------------------------------


shinyServer(function(input, output, session) {

  precinct_summary <- reactive({

    map_click <- input$precinct_map_shape_click

    if(is.null(map_click)){
      precicnt_filter <- 1
    } else {
      precicnt_filter <- map_click$id
    }

    ds0 %>% filter(precinct == precicnt_filter) %>%
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

    shinyjs::html(id = "title_placeholder", html = paste0("Precicnt:", click$id))


  })


})




