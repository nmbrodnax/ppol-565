# scraper.R
# NaLette Brodnax
# PPOL 565, Spring 2019

library(rvest)
library(tidyverse)

# ACCESS
# ==========================
webpage = read_html('http://jse.amstat.org/jse_data_archive.htm')

# PARSE
# ==========================
links <- html_nodes(webpage, css = "a")
link_data <- data.frame(name = html_text(links),
                        link = html_attr(links, 'href'))
link_data <- link_data %>% 
  filter(grepl('.txt', name))

# TRANSFORM
# ==========================
link_data <- link_data %>% 
  mutate(type = ifelse(grepl('dat', name), 'dat', 'doc'))

# STORE
# ==========================
write.csv(link_data, "data_links.csv", row.names = FALSE)

# download a subset of the data
host = 'http://jse.amstat.org'

datasets <- link_data %>% 
  head(10) %>%
  filter(type == 'dat') %>% 
  mutate(url = paste(host, as.character(link), sep = "/"))

for (i in 3:5){
  f <- file(as.character(datasets$name[i]))
  page <- read_html(datasets$url[i])
  text <- html_text(page)
  writeLines(text, f)
  close(f)
}
