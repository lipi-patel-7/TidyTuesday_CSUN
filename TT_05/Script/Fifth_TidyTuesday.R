## This Script is for Tidy Tuesday #5 ##
## Created by: Lipi Patel ##
## Date: 2023-04-03 ##


# Load the libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggplot2)
library(tidyr)
library(dbplyr)
library(ggthemes)

# Read the data
student_debt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/student_debt.csv')

# View the data
glimpse(student_debt)
View(student_debt)

# Create a ggplot
student_debt %>%
  ggplot(mapping = aes(x = year, y = loan_debt, color = race)) + # assigning x and y axes
  geom_line() + # choose a type of geom
  geom_point() + # adding a geom layer for better visualization
  labs(x = "Year", y = "Load Debt (in dollars, $)", 
       title = "The variation in debt of loan from students of different races") + # adds labels to axes
  theme(plot.title = element_text(hjust = 1.0)) + # centers plot title
  theme(panel.background = element_rect(fill = 'lightblue', color = 'purple')) +
  scale_x_continuous(breaks = c(1980, 1985, 1990, 1995, 2000, 2005, 2010, 2016, 2020)) + # set marks for x and y axes
  scale_y_continuous(breaks = c(2000, 4000, 6000, 8000, 10000, 12000, 14000, 16000)) +
  theme_igray()  # sets theme to classic

# Save your plot
ggsave(here("TT_05","Output","Loan debt and student races.png"),
       width = 8, height = 6) # in inches)

###########################################################################################################