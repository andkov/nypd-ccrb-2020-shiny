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

path_input <-  "../nypd-ccrb-2020/data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"


# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)


# ---- server ------------------------------------------------------------------


shinyServer(function(input, output, session) {

  graph <- reactive(
    {
      var <- input$univariate_variable

      d <- ds0 %>% select(all_of(var))


      if(typeof(pull(d)) %in% c("double","integer")){
        g <- d %>% TabularManifest::histogram_continuous(var)
      } else {
        g <- d %>% TabularManifest::histogram_discrete(var)
      }

      return(g)
    }
  )

  output$plot <- renderPlot({graph()})











})




