#' Title
#'
#'
#' @importFrom ggplot2 ggplot
#'
#' @param d
#' @param var1
#' @param var2
#' @param label1
#' @param label2
#' @param labels
#' @param voption
#'
#' @return
#' @export
#'
#' @examples

# Function for exploring relationship between two categorical variables
make_bi_bar_graph <- function(d, var1, var2, label1, label2, labels=F,voption="plasma"){
  # d <- dsm2
  # var1 <- "sex"
  # var2 <- "sex"
  #
  d1 <- d %>%
    group_by(.dots = c(var1, var2) )%>%
    summarize(
      n_people = n()
    ) %>%
    ungroup() %>%
    mutate(
      total = sum(n_people, na.rm =T)
    ) %>%
    group_by(.dots = var1) %>%
    mutate(
      total_1 = sum(n_people, na.rm = T)
      ,pct_1 = scales::label_percent()(total_1/total)
      ,pct_12 = scales::label_percent()(n_people/total_1)
    )
  n_total = d1 %>% pull(total) %>% unique()

  g1 <- d1 %>%
    ggplot2::ggplot(ggplot2::aes_string(x = var1, y = "n_people", fill = var2 ))+
    ggplot2::geom_col(position = ggplot2::position_dodge())+
    ggplot2::geom_text(ggplot2::aes(label = n_people),position = ggplot2::position_dodge(.9), vjust = 1.5, color = "white", size = 5 )+
    ggplot2::scale_fill_viridis_d(begin = 0, end = .8, direction = -1, option = voption)+
    ggplot2::labs( title = paste0("Sample size, N = ", n_total))+
    ggplot2::scale_y_continuous(expand=ggplot2::expansion(mult = c(0,.1)))
  # coord_flip()

  if(var1 == var2){
    g1 <- g1 +
      ggplot2::geom_text(ggplot2::aes_string(label = "pct_1"),position = ggplot2::position_dodge(.9), vjust = -.5, color = "black", size = 4)
  }else{
    g1 <- g1 +
      ggplot2::geom_text(ggplot2::aes_string(label = "pct_12"),position = ggplot2::position_dodge(.9), vjust = -.5, color = "black", size = 4)
  }

  g1 + ggplot2::labs(y = "Number of respondents", title = paste0("Bivariate relationship between (",var1,") and (",var2,")"))

}
