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
library(TabularManifest)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"


# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)


# ---- server ------------------------------------------------------------------


shinyServer(function(input, output, session) {

  precinct_summary <- reactive({
    ds0 %>% filter(precinct == input$precinct_select) %>%
      summarise(
        allegations = n()
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
    )
  })


  #example
  # output$table <- renderTable({precinct_summary()$allegations})



})




