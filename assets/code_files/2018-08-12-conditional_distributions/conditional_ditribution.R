library(tidyverse)
library(doParallel)
registerDoParallel(2)

#--- conditional distribution Y|X=x

n_samp <- 10000
df12 <- 0:5
samp <- foreach(i = df12, .combine = "cbind") %dopar% {
  rf(n_samp, df1 = exp(i), df2 = 2^i)
}

colnames(samp) <- df12

samp_df <- as_data_frame(samp) %>%
  gather(distribution, sample) %>%
  mutate(distribution = factor(distribution, levels = df12,
                               labels = paste0("P(Y | X = ", df12, ")")))

samp_df %>% ggplot(aes(sample, fill = distribution)) +
  geom_density() +
  facet_wrap(~distribution) +
  xlim(0, 5) +
  xlab(NULL) + ylab(NULL) +
  theme(legend.position = "none")

ggsave("../../img/2018-08-12-conditional_distributions/conditional_densities.png")

#--- marginal distribution of Y

samp <- foreach(i = 1:n_samp, .combine = "c") %dopar% {
  x <- rbinom(n=1, size=5, prob=0.5)
  rf(1, df1 = exp(x), df2 = 2^x)
}

marginal_df <- data_frame(sample = samp) %>%
  mutate(distribution = "P(Y)")

samp_df %>% ggplot(aes(sample, fill = distribution)) +
  geom_density(alpha = 0.1) +
  geom_density(data = marginal_df, alpha = 0.7) +
  xlim(0, 5) + xlab(NULL) + ylab(NULL) +
  theme(legend.title = element_blank())

ggsave("../../img/2018-08-12-conditional_distributions/marginal_density.png")

#--- conditional expectation

plot(2:10, 2^(2:10)/(2^(2:10) - 2))

