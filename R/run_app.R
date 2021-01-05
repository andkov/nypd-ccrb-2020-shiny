#' Run the Shiny Application
#'
#' @importFrom shiny shinyApp



run_app <- function(){
  shinyApp(ui = ui, server = app_server)
}
