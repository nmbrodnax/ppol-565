# apiquery.R
# NaLette Brodnax
# PPOL 565, Spring 2019

library(httr)
library(jsonlite)

# REVIEW
# ==========================
host <- 'http://api.datausa.io/api/'
# https://github.com/DataUSA/datausa-api/wiki/DataAPI

# ACCESS
# ==========================
# build API get request
required_params <- "?show=cip&sumlevel=2"
optional_params <- "&year=2015&university=131496"
columns <- "&required=grads_total,grads_men,grads_women"
url <- paste(host, required_params, optional_params, columns, sep = "")

print(url)

# check the http status
response <- GET(url)
http_status(response)

# PARSE
# ==========================
content <- content(response, as = "text", encoding = "UTF-8")
degrees <- fromJSON(content)


# TRANSFORM
# ==========================
data <- as.data.frame(degrees$data)
colnames(data) <- degrees$headers

# STORE
# ==========================
write.csv(data, "ipeds_degrees_cip.csv", row.names = FALSE)
