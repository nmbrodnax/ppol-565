# Visualization with R
# NaLette Brodnax
# PPOL 565, Spring 2019

library(tidyverse)

# Import data
counties <- read_csv(file = '../data/county_data.csv',
                     col_names = TRUE, 
                     col_types = 'cccnnnnnnnnncc')

# Histogram
counties %>% 
  ggplot(aes(adult_pop)) + geom_histogram(bins = 50) 

# Histogram of transformed scale
counties %>% 
  mutate(log_pop = log(adult_pop)) %>% 
  ggplot(aes(log_pop)) + geom_histogram(bins = 50)

# Always add title and labels
counties %>% 
  mutate(log_pop = log(adult_pop)) %>% 
  ggplot(aes(log_pop)) + geom_histogram(bins = 50) + 
  xlab('Log Adult Population') + ylab('Count') + 
  ggtitle('Histogram of Adult Population')

# Scatter plot
counties %>% 
  mutate(log_pop = log(adult_pop)) %>% 
  ggplot(aes(log_pop, median_income)) + geom_point() + 
  xlab('Log Adult Population') + ylab('Median Income') + 
  ggtitle('Median Income by County Size')

# Scatter plot with transformed scale
counties %>% 
  mutate(log_pop = log(adult_pop), 
         median_income_k = median_income/1000) %>% 
  ggplot(aes(log_pop, median_income_k)) + geom_point() + 
  xlab('Log Adult Population') + ylab('Median Income (K)') +
  ggtitle('Median Income by County Size')

ggsave(filename = 'county_inc_size.pdf')
