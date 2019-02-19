library(tidyverse)

setwd("C:/Users/Anna V/Documents/GitHub/ppol-565-av685/!lab_20180219")

## PART 1
# Import data from FTC website and combine into one dataframe
host <- 'https://www.ftc.gov/system/files/attachments/do-not-call-dnc-reported-calls-data/dnc_complaint_numbers_2019-'
dates <- c('02-04', '02-05', '02-06', '02-07', '02-08')

dnc <- dates %>% 
  map(function(date) paste(host, date, '.csv', sep = "")) %>% 
  map(function(url) read_csv(url, col_types = 'cccccccc')) %>% 
  bind_rows()

## PART 2
# Assess missing data
tally_missing <- function(df){
  missing <- df %>% 
    mutate_all(is.na) %>% 
    summarise_all(sum) %>% 
    gather(variable, missing)
  return(missing)
}
print(tally_missing(dnc))

## PART 3
# Replace Consumer_City with Description and drop missing values
ac <- read_csv('data/area_codes_raw.csv', col_types = 'ccc')
dnc <- dnc %>% 
  left_join(ac, by = c('Consumer_Area_Code' = 'Area Code')) %>% 
  select(-Consumer_City) %>% 
  na.omit()
print(tally_missing(dnc))

## PART 4
# Visualize calls by categories
dnc %>% 
  group_by(Subject) %>% 
  summarise(Complaints = n()) %>% 
  ggplot(aes(x=reorder(Subject, Complaints), y=Complaints)) + geom_bar(stat='identity') + 
  coord_flip() + xlab('Subject')

dnc %>% 
  group_by(Consumer_State) %>% 
  summarise(Complaints = n()) %>% 
  ggplot(aes(x=reorder(Consumer_State, Complaints), y=Complaints)) + 
  geom_bar(stat='identity') + coord_flip() + xlab('Consumer_State')

dnc %>% 
  group_by(Recorded_Message_Or_Robocall) %>% 
  summarise(Complaints = n()) %>% 
  ggplot(aes(x=reorder(Recorded_Message_Or_Robocall, Complaints), y=Complaints)) + 
  geom_bar(stat='identity') + coord_flip() + 
  xlab('Recorded_Message_Or_Robocall')

## PART 5
# Summarize the most offending phone numbers
Complaints <- dnc %>% 
  group_by(Company_Phone_Number) %>% 
  summarise(Complaints = n()) %>% 
  arrange(desc(Complaints)) 

summary(Complaints)

# Distribution of Total_Calls greater than 10
Complaints %>% 
  filter(Complaints > 10) %>% 
  ggplot(aes(Complaints)) + geom_histogram(bins = 25)

# Proportion of phone numbers made more than 10 calls?
count(filter(Complaints, Complaints > 10))/count(Complaints)

# BONUS
# Area code data from https://www.bennetyee.org/ucsd-pages/area.html 
area <- '.*: (.*) \\(.*\\)'
match_matrix <- as.tibble(str_match(ac$Description, area))

ac %>% 
  bind_cols(match_matrix) %>% 
  mutate(Area = V2) %>% 
  select(-V1, -V2) %>% 
  write_csv(path='../data/area_codes_cleanR.csv', na = '') %>% 
  head()
