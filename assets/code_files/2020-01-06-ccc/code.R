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

ggsave("../../img/2020-01-06-ccc/ccc_vs_pearson_no_noise.png")


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

ggsave("../../img/2020-01-06-ccc/ccc_vs_pearson_noise.png")

###########################################
### Diagram of sq dist to 45 degre line
###########################################

df1 = tibble(y1 = 5, y2 = 2.5)
df2 = tibble(y1 = 0:5, y2 = 0:5)
df3 = tibble(y1 = c(5, 3.75, 2.5, 3.75),
             y2 = c(2.5, 3.75, 2.5, 1.25))
df4 = tibble(y1 = c(5, 5), y2 = c(2.5, 5))
set.seed(2020)
y1_rand = runif(8, 0, 5)
df5 = tibble(y1 = y1_rand, y2 = y1_rand + rnorm(8))

df2 %>%
  ggplot(aes(y1, y2)) + geom_line() +
  geom_polygon(data = df3, alpha = 0.5) +
  geom_segment(data = df1,
               mapping=aes(x = y1, y = y2+0.1, xend = y1, yend = y2+2.4),
               arrow=arrow(ends = "both", length = unit(0.1, "inches"))) + #, size=2, color="blue") + 
  geom_segment(data = df1,
               mapping=aes(x = y1, y = y2, xend = y1-1.25, yend = y2+1.25),
               size = 1, color = "blue") +
  geom_point(data = df1) + geom_point(data = df5) +
  xlab(expression(y[1])) + ylab(expression(y[2])) +
  theme_light() + coord_fixed()

ggsave("../../img/2020-01-06-ccc/sq_dist_to_45_degree_line.png", height=2, width=2, units = "in")
