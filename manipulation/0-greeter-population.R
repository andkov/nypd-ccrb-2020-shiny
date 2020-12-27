# This script reads NYPD Precinct data from
# https://johnkeefe.net/nyc-police-precinct-and-census-data

rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run.
cat("\f") # clear console when working in RStudio


# ---- load-libraies -----------------------------------------------------------
library(tidyverse)

# ---- declare-globals ---------------------------------------------------------

path_input <-  "./data-unshared/raw/nyc_2010pop_2020precincts.csv"



census_race_labels <- c(
 "total"               = "P0010001"
 ,"total_one_race"     = "P0010002"
 ,"white"              = "P0010003"
 ,"black"              = "P0010004"
 ,"american_indian"    = "P0010005"
 ,"asain"              = "P0010006"
 ,"native_hawaiian"    = "P0010007"
 ,"other"              = "P0010008"
 ,"more_than_one_race" = "P0010009"
 ,"hispanic"           = "P0020002"
 ,"not_hispanic"       = "P0020003"
)


# ---- load-data ---------------------------------------------------------------

ds0 <- read_csv(path_input)


# ---- tweak-data --------------------------------------------------------------


ds1 <- ds0 %>% select(precinct_2020,all_of(census_race_labels))
