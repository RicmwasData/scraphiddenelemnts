library(rvest)
library(V8)   

URL <- "http://projects.fivethirtyeight.com/2016-election-forecast/washington/#now"

pg <- read_html(URL)

js <- html_nodes(pg, xpath=".//script[contains(., 'race.model')]") %>%  html_text()
 