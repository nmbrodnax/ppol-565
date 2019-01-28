# Data Wrangling with R
# NaLette Brodnax
# PPOL 565, Spring 2019

library(tidyverse)

# Import data
df <- read_csv(file = '../data/county_demographics_2016.csv',
               col_names = TRUE, col_types = 'cnnnnnnnnn')

# Need to pad county fips with zeroes
df <- read_csv(file = '../data/county_demographics_2016.csv',
               col_names = TRUE, col_types = 'cnnnnnnnnn') %>% 
  mutate(fips = str_pad(fips, width = 5, side = 'left', pad = '0'))

fips <- read_csv(file = '../data/fips.csv', col_names = TRUE, 
                 col_types = 'cccccccc') %>% 
  select(state, statefp, countyfp, countyname, fips)

# Combine data
df <- df %>% 
  left_join(fips, by = "fips") %>% 
  select(state, countyname, everything())
# ignore additional observations due to Wisconsin

# Drop missing values
df <- df %>% 
  drop_na()

# Filter by name
rates <- df %>% 
  select(state, countyname, pct_poverty, 
         pct_highschool, pct_unemployed)

# Filter by criteria
low_pov <- rates %>% 
  filter(pct_poverty <= 10)

# Grouping
state_avg <- low_pov %>% 
  group_by(state) %>% 
  summarise(avg_pov = mean(pct_poverty),
            avg_hs = mean(pct_highschool),
            avg_unemp = mean(pct_unemployed))

# Export data
write_csv(state_avg, path = '../data/state_avg.csv')
write_csv(df, path = '../data/county_data.csv')
