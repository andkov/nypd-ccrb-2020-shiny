make_bi_mosaic <- function(d, var1, var2){

  # d <- dsm2 %>% select(sex, class_standing)
  # var1 <- "class_standing"
  # var2 <- "sex"

  d1 <- d %>%
    dplyr::rename(
      "v1" = var1
      ,"v2" = var2
    ) %>%
    mutate(
      v1 = forcats::fct_drop(v1)
      ,v2 = forcats::fct_drop(v2)
    )

  mosaicplot(~v1 + v2, data = d1,
             main = paste0("Bivariate distribution between (", var1, ") and (", var2,")")
             ,xlab = var1, y = var2
             ,shade = TRUE)
}
