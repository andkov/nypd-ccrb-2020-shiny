## Code to prepare `NYPD CCRB Cleaned` dataset

# Currently no manipulations are done
# This data is cleaned in the NYPD CCRB repo
# TODO: Update App data source to match NYPD-CCRB-2020 Repo


path_input <- "./data-raw/nypd-ccrb-cleaned.csv"

nypd_ccrb_cleaned <- readr::read_csv(path_input)


# ---- save-data ---------------------------------------------------------------
usethis::use_data(nypd_ccrb_cleaned, overwrite = TRUE)
