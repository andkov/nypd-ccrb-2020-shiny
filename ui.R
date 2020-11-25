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
library(TabularManifest)
library(shinythemes)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"


# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)


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
