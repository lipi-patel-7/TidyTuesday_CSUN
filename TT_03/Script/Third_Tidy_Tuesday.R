### This is my third tidy tuesday plot ###
### Created by: Lipi ###
### Date: 2023/18/03 ###

# Load the Libraries

library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)
library(maps)
library(mapdata)
library(mapproj)

# Read in your data
bigfoot <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-13/bigfoot.csv')

glimpse(bigfoot)
View(bigfoot)

# Generate a map of United States
USA <- map_data("usa")
head(USA)
View(USA)

# get data for states
States<-map_data("state")
head(States)
View(States)

# filters out only Montana State map
Mon_data<-States %>%
  filter(region == "montana")
View(Mon_data)

# Filters out Montana state from bigfoot data
Mon_bigfoot <- bigfoot %>%
  filter(state == "Montana")
View(Mon_bigfoot)

# remove the 19th row with far-end value
updated_Mon_bigfoot <- Mon_bigfoot[-19,]
View(updated_Mon_bigfoot)

ggplot()+ # creates a ggplot of montana
  geom_polygon(data = Mon_data, # adds axes and colors 
               aes(x = long, 
                   y = lat), 
                 # group = group),
               color = "black") +
  coord_map()+


geom_point(data = updated_Mon_bigfoot, # adds points as per mutated meteorites data
           aes(x = longitude, # assigns axes 
               y = latitude, 
               color = classification))+ 
  labs(x = "Longitude", y = "Latitude", title = "Classified distribution of bigfoot in Montana") + # adds labels to axes and title
  coord_map(projection = "mercator")
            xlim = c(-180,180) # Use a mercator projection

# Save your plot
ggsave(here("TT_03","Output","bigfoot_Tidy_Tuesday.png"),
       width = 5, height = 5) # in inches)