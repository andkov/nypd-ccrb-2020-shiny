#' @import shiny
#' @importFrom shinydashboard infoBoxOutput
#' @importFrom shinyjs useShinyjs
#'
#'
#'

# ---- load-libraies -----------------------------------------------------------
# library(shiny)
# library(tidyverse)
# library(shinydashboard)
# library(shinythemes)
# library(leaflet)

# ---- declare-globals ---------------------------------------------------------



# ---- load-data ---------------------------------------------------------------


# ---- UI-parts ----------------------------------------------------------------

# HEADER
header <- shinydashboard::dashboardHeader(
  title = "NYPD-CCRB"
)

# SIDEBAR
sidebar <- shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    shinydashboard::menuItem(
      text = "Map"
      ,tabName = "map"
      ,icon = icon("map")
      ,selected = TRUE
      )
    ,shinydashboard::menuItem(
      text = "Reports"
      ,tabName = "reports"
      ,icon = icon("folder")
    )
    ,shinydashboard::menuItem(
      text = "Graphs"
      ,tabName = "graphs"
      ,icon = icon("chart-line")
    )
  )
)

# sidebar <- shinydashboard::dashboardSidebar(disable = TRUE)

# BODY
body <- shinydashboard::dashboardBody(
  shinyjs::useShinyjs()
  ,shinydashboard::tabItems(
    shinydashboard::tabItem(
      tabName = "map"
      ,fluidRow(
        column(
          width = 12
          ,align = "center"
          ,tags$h2(id = "title_placeholder", "Precinct: 1")
        )
      )
      ,fluidRow(
        shinydashboard::infoBoxOutput("allegations_info")
        ,shinydashboard::infoBoxOutput("complaint_info")
        ,shinydashboard::infoBoxOutput("officers_complaint_info")
      )
      ,fluidRow(
        shinydashboard::infoBoxOutput("substantiated")
        ,shinydashboard::infoBoxOutput("exonerated")
        ,shinydashboard::infoBoxOutput("unsubstantiated")
      )
      ,fluidRow(
        shinydashboard::box(
          leaflet::leafletOutput("precinct_map", height = 500)
          ,width = 12
        )
      )
      ,fluidRow(
        shinydashboard::box(
          textOutput("map_text")
        )
      )
    )
    ,shinydashboard::tabItem(
      tabName = "reports"
      ,reports_ui("reports1")
    )
    ,shinydashboard::tabItem(
      tabName = "graphs"
      ,h2("Nothing Here Yet")
    )
  )
)






# ---- Main-UI -----------------------------------------------------------------
app_ui <- function(){
  shinydashboard::dashboardPage(header,sidebar,body, skin = 'black')
}
