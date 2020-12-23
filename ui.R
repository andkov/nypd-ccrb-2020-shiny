#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ---- load-libraies -----------------------------------------------------------
library(shiny)
library(tidyverse)
library(shinydashboard)
library(shinythemes)
library(leaflet)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"


# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)


# ---- UI-parts ----------------------------------------------------------------

# HEADER
header <- dashboardHeader(
  title = "NYPD-CCRB"
)

# SIDEBAR
# sidebar <- dashboardSidebar(
#   selectInput(
#     inputId = "precinct_select"
#     ,label  = "Choose Precint"
#     ,choices = sort(unique(ds0$precinct, na.rm = TRUE))
#   )
# )

  sidebar <- dashboardSidebar(disable = TRUE)

# BODY
body <- dashboardBody(
  shinyjs::useShinyjs()
  ,fluidRow(
    column(
      width = 12
      ,align = "center"
      ,tags$h2(id = "title_placeholder")
    )
  )
  ,fluidRow(
      infoBoxOutput("allegations_info")
      ,infoBoxOutput("complaint_info")
      ,infoBoxOutput("officers_complaint_info")
  )
  ,fluidRow(
    box(
      leafletOutput("precinct_map", height = 500)
      ,width = 12
    )
  )
  ,fluidRow(
    box(
      textOutput("map_text")
    )
  )



)






# ---- Main-UI -----------------------------------------------------------------

dashboardPage(header,sidebar,body)
