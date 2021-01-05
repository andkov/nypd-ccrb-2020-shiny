#' Run the Shiny Application
#'
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options


run_app <- function(){
  shinyApp(ui = ui, server = server)
}
