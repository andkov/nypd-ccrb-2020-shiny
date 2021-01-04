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
library(tidyverse)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/CCRB-Complaint-Data_202007271729/allegations_202007271729.csv"

population_data <- "./data-public/app-ready-population-data.rds"

# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)

ds_pop <- read_rds(population_data)

# ---- filter ------------------------------------------------------------------

precinct_value <- 75

ds1 <- ds0 %>% filter(precinct == precinct_value)


ds1_summary <- ds1 %>% summarise(
  allegations = n()
  ,substantiated = sum(str_detect(board_disposition,"Substantiated"))
  ,exonerated = sum(str_detect(board_disposition,"Exonerated"))
  ,unsubstantiated  = sum(str_detect(board_disposition,"Unsubstantiated"))
  ,officers_with_complaints = n_distinct(first_name,last_name)
)

