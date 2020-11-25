#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# ---- UI-parts ----------------------------------------------------------------








# ---- Main-UI -----------------------------------------------------------------

shinyUI(
  navbarPage(
    "NYPD-CCRB"
    ,theme = shinytheme("slate")
    ,tabPanel(
      "Data Explorer"
      ,sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId  = "univariate_variable"
            ,label = "Choose Variable"
            ,choices = names(ds0)
            )
          )
        ,mainPanel(
          plotOutput("plot")

          )
        )
      )
    )











)
