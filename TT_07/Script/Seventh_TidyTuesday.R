## This Script is for Tidy Tuesday #7 ##
## Created by: Lipi Patel ##
## Date: 2023-05-06 ##


# Load the libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dbplyr)
library(ggthemes)
library(patchwork)

# Read in data
surveys <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-02/surveys.csv')

glimpse(surveys)
View(surveys)

# Filter the data
filtered_surveys <- surveys %>% # creates new data and opens surveys data
  drop_na(year, hfl, wgt) %>% # removes empty values
  select(year, hfl, wgt) %>% # selects these columns
  filter(year == "1980"| year == "1985"| year == "1990"| year == "1995"| year == "2000") %>%
  group_by(year) %>%
  summarise(mean_hfl = mean(hfl, na.rm = TRUE), # calculates mean of hindfoot length
            mean_wgt = mean(wgt, na.rm = TRUE)) # calculates mean of weight
head(filtered_surveys)

# Plot the data
p1 <- filtered_surveys %>% # creates plot 1 and uses filtered surveys data
  ggplot(mapping = aes(x = year, y = mean_hfl)) + # assigning x and y axes
  geom_point(size=3) + # point size for lollipop
  geom_segment(aes(x=year, # assigns axes variables
                   xend=year, 
                   y=0, 
                   yend=mean_hfl)) +
  labs(x = "Year", y = "Hindfoot length (inches)") # adds label to the axes

# similarly create second plot
p2 <- filtered_surveys %>% # creates plot 2 and uses filtered surveys data
  ggplot(mapping = aes(x = year, y = mean_wgt)) + # assigning x and y axes
  geom_point(size=3) + # point size for lollipop
  geom_segment(aes(x=year, # assigns axes variables
                   xend=year, 
                   y=0, 
                   yend=mean_wgt)) +
  labs(x = "Year", y = "Weight (pounds)") # adds label to the axes

p1+p2 + # patches both plots together
  labs(title = "Comparision of mean hindfoot length and weight of rodents") + # adds labels to axes
  theme(plot.title = element_text(hjust = 1.5)) # centers plot title

# Save your plots 
ggsave(here("TT_07","Output","Rodents.png"),
       width = 7, height = 4) # in inches)
