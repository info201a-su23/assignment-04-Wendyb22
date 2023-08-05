library(maps)
library(dplyr)
library(ggplot2)
library(scales)
# Get the state borders data for the US
us_states <- map_data("state")

# Filters all years to get only the year 2015
prison_rate_2013 <- prison_rate %>%
  filter(year == "2013")

# Gets the total number of black prison population per state
total_per_state <- prison_rate_2013 %>% 
  group_by(state) %>%
  summarise(black_prison_pop_rate = mean(black_prison_pop_rate, na.rm = TRUE))

# Changes the abbreviations to state names
state_mapping <- setNames(state.name, state.abb)

# Adds the full state name from abbreviation
total_per_state$full_state_name <- state_mapping[total_per_state$state]
state_shape <- map_data("state")

# Combines the two data sets
total_per_state <- total_per_state %>% 
  mutate(full_state_name = tolower(full_state_name))
prison_state_shape <- left_join(total_per_state, state_shape, by = c("full_state_name" = "region"))

# Plots the map
black_prison_pop_by_state_map <- ggplot(data = prison_state_shape) +
  geom_polygon(mapping = aes(x = long,
                             y = lat,
                             group = group,
                             fill = black_prison_pop_rate)) +
  scale_fill_continuous(low = "yellow",
                        high = "red",
                        limits = c(0, 4000),
                        labels = scales::label_number(scale = 1e-3, accuracy = 0.1, suffix = "k")) +
  labs(title="Average Black Prison Population Rate by State in 2013",
       fill="Average Black Prison Population Rate") + 
  coord_map()
print(black_prison_pop_by_state_map)
