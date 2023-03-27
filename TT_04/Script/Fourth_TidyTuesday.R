### This is my fourth tidy tuesday plot ###
### Created by: Lipi ###
### Date: 2023/26/03 ###

# Load the libraries
library(here)
library(tidyverse)
library(ggplot2)
library(tidytuesdayR)
library(tidyr)
library(dplyr)
library(ggthemes)
library(r02pro)

# Read the data
languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-21/languages.csv')

# View the data
View(languages)
glimpse(languages)

# Creating a ggplot
languages %>% # opens data
  ggplot(mapping = aes(x = github_language_type, 
                       y = number_of_users, 
                       fill = number_of_users)) + # assigning x and y axes
  geom_col() + # choose a type of geom
  #  scale_y_log10() + # changes y axis to log scale
  labs(x = "Types of languages", y = "Number of users", 
       title = "Users of different github languages") + # adds labels to axes
  scale_color_hue() +
  theme(plot.title = element_text(hjust = 1.0)) + # centers plot title
  theme_gdocs() + # sets theme
  theme(axis.title = element_text(size = 15,
                                  color = "black"))

### Save your plot ###

ggsave(here("TT_04","Output","Users of different github languages.png"),
       width = 7, height = 4) # in inches)


####################################################################################################