## This Script is for Tidy Tuesday #1 ##
## Created by: Lipi Patel ##
## Date: 2023-03-04 ##


## Load the libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dbplyr)
library(ggthemes)

## Read the data
bob_ross <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-21/bob_ross.csv')

## View the data
glimpse(bob_ross) # to inspect the data
View(bob_ross)

# Pivoting it longer
edited_bob_ross <- bob_ross %>% # create new data
  drop_na() %>% # drops NAs
  pivot_longer(cols = Black_Gesso:Alizarin_Crimson, # chooses columns from and to
               names_to = "color", # names them to "color"
               values_to = "count") %>% # values are labeled as "count"
  filter(count == TRUE) %>% # filters out the TRUE values and skips the FALSE ones
  group_by(season, color) %>% # groups by season
  summarize(count = n())
View(edited_bob_ross)


### Making a ggplot ###

edited_bob_ross %>% # opens edited_bob_ross
ggplot(mapping = aes(x = season, y = count, fill = color, size = 14)) + # assigning x and y axes
geom_raster()+ # choose a type of geom
facet_wrap(~color, scales = "free")+ # sets the scale to free
labs(x = "Season", y = "Count", 
     title = "Count of colors used in different seasons") + # adds labels to axes
  theme(plot.title = element_text(hjust = 1.0)) + # centers plot title
  theme_classic()  # sets theme to classic

### Save your plot ###
ggsave(here("TT_01","Output","Colors used in different seasons.png"),
       width = 15, height = 10) # in inches)

###########################################################################################################