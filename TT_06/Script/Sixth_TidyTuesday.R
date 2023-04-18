## This Script is for Tidy Tuesday #6 ##
## Created by: Lipi Patel ##
## Date: 2023-04-16 ##


# Load the libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dbplyr)
library(ggthemes)
library(maps)
library(mapdata)
library(mapproj)


# Read the data
volcano <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-12/volcano.csv')

# View the data
glimpse(volcano)
View(volcano)

# Clean the data
clean_volcano <- volcano %>%
  drop_na()
head(clean_volcano) 

# get data for the entire world
world<-map_data("world")
head(world)


# Plot a map of the world
ggplot()+
geom_polygon(data = world, # opens the world data
             aes(x = long, # assigns axes
                 y = lat, 
                 group=group),
             fill = "black") +
  geom_point(data = clean_volcano, # add points as per volcano data
             aes(x = longitude, # assigns axes 
                 y = latitude), color="red", size = 0.75)+ # plots volcanos at different locations around world
  geom_smooth()+
  theme(panel.background = element_rect(fill = "lightblue"))+ # changes background to lightblue for water
  labs(x = "Latitude", y = "Longitude", title = "Distribution of Volcanic eruptions throughout the world")+ # adds labels to axes and title
  coord_map(projection = "mercator",
            xlim = c(-180,180)) # Use a mercator projection


# Save your plot
ggsave(here("TT_06","Output","Distribution of volcanic eruptions throughout the world.png"),
       width = 8, height = 6) # in inches)


###########################################################################################################