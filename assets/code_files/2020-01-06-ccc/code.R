library(tidyverse)
library(grid)  # for annotation_custom

my_ccc <- function(x, y) {
  n <- length(x)
  sxy <- cov(x, y) * (n-1) / n
  sx2 <- var(x) * (n-1) / n
  sy2 <- var(y) * (n-1) / n
  ccc <- 2 * sxy / (sx2 + sy2 + (mean(x) - mean(y))^2)
  return(ccc)
}

###########################################
### Comparison of CCC vs. Pearson's corr
###########################################

#--- No noise

xy <- tibble(x = 0:20*5, y = 0:20*5)
xy_locshift <- xy %>% mutate(y = y + 20, shift = "loc")
xy_scaleshift <- xy %>% mutate(y = y * 1.5, shift = "scale")
xy_locscaleshift <- xy %>% mutate(y = 0.5 * y + 15, shift = "locscale")
xy_inverseshift <- xy %>% mutate(y = -1 * y + 100, shift = "inverse")
xy_yaxis <- xy %>% mutate(x = 0, shift = "yaxis")
xy$shift <- "none"

xy_df <- bind_rows(xy, xy_locshift, xy_scaleshift, xy_locscaleshift, xy_inverseshift, xy_yaxis) %>%
  mutate(shift = factor(shift, levels = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                        labels = c("45 degree line", "location shift", "scale shift", "location+scale shift", "perpendicular", "y-axis")))

annot_df <- tibble(shift = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                   pearson = c(cor(xy$x, xy$y),
                               cor(xy_locshift$x, xy_locshift$y),
                               cor(xy_scaleshift$x, xy_scaleshift$y),
                               cor(xy_locscaleshift$x, xy_locscaleshift$y),
                               cor(xy_inverseshift$x, xy_inverseshift$y),
                               cor(xy_yaxis$x, xy_yaxis$y)),
                   ccc = c(my_ccc(xy$x, xy$y),
                           my_ccc(xy_locshift$x, xy_locshift$y),
                           my_ccc(xy_scaleshift$x, xy_scaleshift$y),
                           my_ccc(xy_locscaleshift$x, xy_locscaleshift$y),
                           my_ccc(xy_inverseshift$x, xy_inverseshift$y),
                           my_ccc(xy_yaxis$x, xy_yaxis$y)),
                   x_coord = rep(55, 6), y_coord = rep(125, 6)) %>%
  mutate(shift = factor(shift, levels = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                        labels = c("45 degree line", "location shift", "scale shift", "location+scale shift", "perpendicular", "y-axis")))

annot45line <- grobTree(textGrob("45-degree line", x = 0.18,  y = 0.10, hjust=0,
                                 gp = gpar(col = "darkgrey", fontsize = 11)))
xy_df %>%
  ggplot() + geom_point(aes(x, y)) +
    geom_text(aes(x_coord, y_coord,
                  label = paste0("Pearson cor = ", round(pearson, 2), "\nCCC = ", round(ccc, 2)),
                  fontface = 2),
              color = "blue",
              data = annot_df) +
    geom_abline(intercept = 0, slope = 1, color = "darkgrey") +
    annotation_custom(annot45line) +
    facet_wrap(~shift, ncol = 2) + theme_light() +
    labs(x = "", y = "")

ggsave("../../img/2019-12-31-ccc/ccc_vs_pearson_no_noise.png")


#--- With white noise

xy <- tibble(x = 0:20*5 + rnorm(21, 0, 15), y = 0:20*5 + rnorm(21, 0, 15))
xy_locshift <- xy %>% mutate(y = y + 20, shift = "loc")
xy_scaleshift <- xy %>% mutate(y = y * 1.5, shift = "scale")
xy_locscaleshift <- xy %>% mutate(y = 0.5 * y + 15, shift = "locscale")
xy_inverseshift <- xy %>% mutate(y = -1 * y + 100, shift = "inverse")
xy_yaxis <- xy %>% mutate(x = rnorm(21, 0, 15), shift = "yaxis")
xy$shift <- "none"

xy_df <- bind_rows(xy, xy_locshift, xy_scaleshift, xy_locscaleshift, xy_inverseshift, xy_yaxis) %>%
  mutate(shift = factor(shift, levels = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                        labels = c("45 degree line", "location shift", "scale shift", "location+scale shift", "perpendicular", "noisy y-axis")))

annot_df <- tibble(shift = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                   pearson = c(cor(xy$x, xy$y),
                               cor(xy_locshift$x, xy_locshift$y),
                               cor(xy_scaleshift$x, xy_scaleshift$y),
                               cor(xy_locscaleshift$x, xy_locscaleshift$y),
                               cor(xy_inverseshift$x, xy_inverseshift$y),
                               cor(xy_yaxis$x, xy_yaxis$y)),
                   ccc = c(my_ccc(xy$x, xy$y),
                           my_ccc(xy_locshift$x, xy_locshift$y),
                           my_ccc(xy_scaleshift$x, xy_scaleshift$y),
                           my_ccc(xy_locscaleshift$x, xy_locscaleshift$y),
                           my_ccc(xy_inverseshift$x, xy_inverseshift$y),
                           my_ccc(xy_yaxis$x, xy_yaxis$y)),
                   x_coord = rep(35, 6), y_coord = rep(150, 6)) %>%
  mutate(shift = factor(shift, levels = c("none", "loc", "scale", "locscale", "inverse", "yaxis"),
                        labels = c("45 degree line", "location shift", "scale shift", "location+scale shift", "perpendicular", "noisy y-axis")))

annot45line <- grobTree(textGrob("45-degree line", x = 0.18,  y = 0.10, hjust=0,
                                 gp = gpar(col = "darkgrey", fontsize = 11)))
xy_df %>%
  ggplot() + geom_point(aes(x, y)) +
    geom_text(aes(x_coord, y_coord,
                  label = paste0("Pearson cor = ", round(pearson, 2), "\nCCC = ", round(ccc, 2)),
                  fontface = 2),
              color = "blue",
              data = annot_df) +
    geom_abline(intercept = 0, slope = 1, color = "darkgrey") +
    annotation_custom(annot45line) +
    facet_wrap(~shift, ncol = 2) + theme_light() +
    labs(x = "", y = "")

ggsave("../../img/2019-12-31-ccc/ccc_vs_pearson_noise.png")
