library(tidyverse)
library(dplyr)
library(ggplot2)

# load data
prison_rate <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990.csv")

# the average value of total prison incarceration rate across all the counties from 1990 to 2018
avg_total_prison_rate <- mean(prison_rate$total_prison_pop_rate, na.rm = TRUE)

# the average value of black prison incarceration rate across all the counties in year 1990
prison_rate_1990 <- prison_rate %>%
  filter(year == 1990)
avg_black_prison_rate_1990 <- mean(prison_rate_1990$black_prison_pop_rate, na.rm = TRUE)

# the average value of white prison incarceration rate across all the counties in year 1990
prison_rate_1990 <- prison_rate %>%
  filter(year == 1990)
avg_white_prison_rate_1990 <- mean(prison_rate_1990$white_prison_pop_rate, na.rm = TRUE)

# the location where the black incarceration rate is the highest
max_black_prison_rate_county <- prison_rate %>%
  filter(black_prison_pop_rate == max(prison_rate$black_prison_pop_rate, na.rm = TRUE)) %>%
  select(county_name, state)

# the location where the white incarceration rate is the highest
max_white_prison_rate_county <- prison_rate %>%
  filter(white_prison_pop_rate == max(prison_rate$white_prison_pop_rate, na.rm = TRUE)) %>%
  select(county_name, state)

