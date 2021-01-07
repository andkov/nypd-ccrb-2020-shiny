#' Create Precinct Summary
#'
#' @param d A data set containing police precincts
#' @param precinct_filter Precinct to filter data
#'
#' @return return summarized data set
#' @export
#'
#' @examples
create_precinct_summary <- function(d, precinct_filter){

  filter_in <- precinct_filter

  d %>%
    dplyr::filter(precinct == filter_in) %>%
    dplyr::summarise(
      allegations = n()
      ,complaints = n_distinct(complaint_id)
      ,substantiated = sum(str_detect(board_disposition,"Substantiated"))
      ,exonerated = sum(str_detect(board_disposition,"Exonerated"))
      ,unsubstantiated  = sum(str_detect(board_disposition,"Unsubstantiated"))
      ,officers_with_complaints = n_distinct(first_name,last_name)
    )
}











