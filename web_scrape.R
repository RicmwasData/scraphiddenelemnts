
#Load libraries 
library(tidyverse)
library(rvest)


#Read the url 
url <- "https://stats.ncaa.org/contests/5254137/box_score"

#Read the html tags
html <- read_html(url)

#Under div .p-4 we had hidden element called script
circle_data <- html %>%
  html_nodes('.p-4  script')

#Read text from the second element
raw_data<-circle_data[2]%>%
  html_text( trim = T)

# Split the text into individual shots
shots <- unlist(strsplit(raw_data, "\n", fixed = TRUE))

# Extract the components of the shot string
# Use a regular expression to match text within addShot
matches <-  gregexpr("(?<=addShot\\().+?(?=\\);)", shots, perl=TRUE)
# Extract the matched groups
shot_text <- unlist( regmatches(shots, matches))

#show what was contained in the addShot function
"function addShot(x, y, shooting_org, made, play_id, play_description, classes, show_highlight)"

# Convert the vector to a data frame by splitting each string into its components
shots_df <- do.call(rbind.data.frame, strsplit(shot_text, ", ", fixed = TRUE))
# Assign column names to the data frame
colnames(shots_df) <- c("x", "y", "shooting_org", "made", "play_id", "play_description", "classes", "show_highlight")
write.csv(shots_df,'shots_data.csv')
