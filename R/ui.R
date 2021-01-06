#' @import shiny
#' @import shinydashboard
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
      infoBoxOutput("allegations_info")
      ,infoBoxOutput("complaint_info")
      ,infoBoxOutput("officers_complaint_info")
  )
  ,fluidRow(
    box(
      leaflet::leafletOutput("precinct_map", height = 500)
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
ui <- function(){
  dashboardPage(header,sidebar,body)
}
