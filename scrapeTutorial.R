library(RCurl)
library(xml2) 
library(XML)
library(tidyverse)
library(rvest)


#The url 

# Read the HTML content of the website
url<- "https://stats.ncaa.org/contests/5254137/box_score"

# parse url
url_parsed <- htmlParse(getURL(url), asText = TRUE)


#Read the html tags
html <- read_html(url)

#Under div .p-4 we had hidden element called script
circle_data <- html %>%
  html_nodes('.p-4  script')
