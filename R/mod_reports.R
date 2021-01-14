#' @import shiny
#'
#'


reports_ui <- function(id){
  tagList(
    h1("Reports")
    ,tags$hr()
    ,p("The following page contains various reports created from the dataset")
    ,tags$ul(
      tags$li(
        tags$a(
          href = "https://raw.githack.com/dss-hmi/nypd-ccrb-2020/main/analysis/1-first-look/1-first-look.html"
          ,"First Look Report"
          )
      )
      # ADD more reports here
    )
  )
}


reports_server <- function(id){
  moduleServer(id, function(input, output, session){
    # Reports Page contains no server functions currently
  })
}
