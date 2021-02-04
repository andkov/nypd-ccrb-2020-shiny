# Graphing presets
# Use this script to apply graphing options to all graphs in the project
ggplot2::theme_set(
  ggplot2::theme_bw(
  )+
    ggplot2::theme(
      strip.background = ggplot2::element_rect(fill="grey90", color = NA)
    )
)
