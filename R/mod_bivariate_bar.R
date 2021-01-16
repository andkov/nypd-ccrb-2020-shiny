#' @import shiny
#'
#'

select_choices <- c(
  "Rank Now"                  = "rank_now"
  ,"Rank Incident"            = "rank_incident"
  ,"Officer Ethnicity"        = "mos_ethnicity"
  ,"Officer Gender"           = "mos_gender"
  # ,"Officer Age Incident"     = "mos_age_incident"
  ,"Complainant Ethnicity"    = "complainant_ethnicity5"
  ,"Complainant Gender"       = "complainant_gender4"
  # ,"Complainant Age Incident" = "complainant_age_incident"
)




bivar_bar_ui <- function(id){
  tagList(
    fluidRow(
      column(
        width = 2
        ,shinydashboard::box(
          title = "Choose Variables"
          ,width  = NULL
          ,selectInput(
            NS(id,"xvar")
            ,label = "X Variable"
            ,choices = select_choices
          )
          ,selectInput(
            NS(id,"yvar")
            ,label = "y Variable"
            ,choices = select_choices
          )
        )
      )
      ,column(
        width = 10
        ,shinydashboard::box(
          width = NULL
          ,plotOutput(
            NS(id,"bivar_bar_plot")
            ,height = "700px"
          )
        )
      )
    )
  )
}


bivar_bar_server <- function(id){
  moduleServer(id, function(input, output, session){

    output$bivar_bar_plot <- renderPlot({


      make_bi_bar_graph(nypd_ccrb_cleaned, input$xvar, input$yvar)


    })

  })
}
