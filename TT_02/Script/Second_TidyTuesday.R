### This is my second tidy tuesday plot ###
### Created by: Lipi ###
### Date: 2023/09/03 ###

# Load the Libraries

library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)


# Read in Data

plastics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')


# View the Data

glimpse(plastics) # to inspect the data
View(plastics)


# Pivoting it longer

pivoted_data <- plastics %>% # create new data
  drop_na() %>% # drops NAs
  pivot_longer(cols = hdpe:pvc, # chooses columns from and to
               names_to = "types", # names them to "types"
               values_to = "count") %>% # values are labeled as "count"
  filter(count == TRUE) %>% # filters out the TRUE values and skips the FALSE ones
  group_by(types, year = "2020") %>% # groups by country and year
  summarize(count = n())
View(pivoted_data)


### Making a ggplot ###

pivoted_data %>% # opens data
  ggplot(mapping = aes(x = types, y = count, xend = types, yend = 0)) + # assigning x and y axes
  geom_curve(curvature = 0.5,
             angle = 90,
             ncp = 5)+ # choose a type of geom
  labs(x = "Types", y = "Count", 
       title = "Types of plastic causing pollution in the year 2020") + # adds labels to axes
  theme(plot.title = element_text(hjust = 1.0)) + # centers plot title
  theme_economist_white() + # sets theme to bw
  theme(axis.title = element_text(size = 10,
                                  color = "black"))


### Save your plot ###

ggsave(here("TT_02","Output","Types of plastic causing pollution in the year 2020.png"),
       width = 7, height = 4) # in inches)


####################################################################################################