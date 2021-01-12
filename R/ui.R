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
# sidebar <- dashboardSidebar(
#   selectInput(
#     inputId = "precinct_select"
#     ,label  = "Choose Precint"
#     ,choices = sort(unique(ds0$precinct, na.rm = TRUE))
#   )
# )

  sidebar <- shinydashboard::dashboardSidebar(disable = TRUE)

# BODY
body <- shinydashboard::dashboardBody(
  shinyjs::useShinyjs()
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






# ---- Main-UI -----------------------------------------------------------------
app_ui <- function(){
  shinydashboard::dashboardPage(header,sidebar,body)
}
