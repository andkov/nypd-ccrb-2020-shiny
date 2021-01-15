#' @import shiny
#'
#'

select_choices <- c(
  "rank_now"        ="rank_now"
  ,"rank_incident"  ="rank_incident"
  ,"mos_ethnicity"  ="mos_ethnicity"
  ,"mos_gender"  ="mos_gender"
  ,"mos_age_incident"  ="mos_age_incident"
  ,"complainant_ethnicity"  ="complainant_ethnicity"
  ,"complainant_gender"  ="complainant_gender"
  ,"complainant_age_incident" = "complainant_age_incident"
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


      make_bi_bar_graph(allegations, input$xvar, input$yvar)


    })

  })
}
