#' Title
#'
#' @param d
#' @param xvar
#' @param yvar
#' @param groupvar
#' @param jitterwidth
#' @param jitterheight
#' @param xlabel
#' @param ylabel
#' @param grouplabel
#'
#' @return
#' @export
#'
#' @examples
scatter_by_groups <- function(
  d,xvar, yvar, groupvar, jitterwidth=0, jitterheight=0,  xlabel = xvar, ylabel=yvar, grouplabel=groupvar
){
  # d <- dsm2
  # xvar = "n_tx_knowledge"
  # xvar = "n_tx_helpful"
  # yvar = "hr_support"
  # groupvar = "sex"

  g1 <- d %>%
    ggplot2::ggplot(ggplot2::aes_string(x = xvar, y = yvar, color = groupvar))+

    ggplot2::geom_point(shape = 21, size = 3, alpha = .4,
               position = ggplot2::position_jitter(width=jitterwidth,height = jitterheight, seed = 42))+
    ggplot2::scale_color_viridis_d(begin = 0, end = .6, option = "plasma")+
    ggplot2::geom_smooth(method="lm", se = F)+
    ggpmisc::stat_poly_eq(formula = y ~ + x ,
                          ggplot2::aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")),
                          parse = TRUE)+
    ggplot2::labs(
      title = paste0("Relationship between (", yvar,") and (", xvar,") for different levels of (",groupvar,")"),
      caption = paste0("N = ", nrow(d)),
      x = xlabel,
      y = ylabel,
      color = grouplabel
    )
  return(g1)

}
