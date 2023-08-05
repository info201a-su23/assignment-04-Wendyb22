# Filter the data for North Carolina, Nebraska, and Washington
prison_rate_NC <- prison_rate %>%
  filter(state == "NC")
prison_rate_NE <- prison_rate %>%
  filter(state == "NE")
prison_rate_WA <- prison_rate %>%
  filter(state == "WA")

# the average White and Black incarceration rates for each state across all years
avg_white_NC <- mean(prison_rate_NC$white_prison_pop_rate, na.rm = TRUE)
avg_white_NE <- mean(prison_rate_NE$white_prison_pop_rate, na.rm = TRUE)
avg_white_WA <- mean(prison_rate_WA$white_prison_pop_rate, na.rm = TRUE)

avg_black_NC <- mean(prison_rate_NC$black_prison_pop_rate, na.rm = TRUE)
avg_black_NE <- mean(prison_rate_NE$black_prison_pop_rate, na.rm = TRUE)
avg_black_WA <- mean(prison_rate_WA$black_prison_pop_rate, na.rm = TRUE)

average_data <- data.frame(
  state = c("NC", "NE", "WA", "NC", "NE", "WA"),
  race = c("White", "White", "White", "Black", "Black", "Black"),
  average_rate = c(avg_white_NC, avg_white_NE, avg_white_WA, avg_black_NC, avg_black_NE, avg_black_WA),
  year = rep(unique(prison_rate$year), 6)
)

# Create the chart
chart2 <- ggplot(data = average_data, aes(x = year, y = average_rate, color = race)) +
  geom_line() +
  labs(
    title = "Comparison of Average White and Black Incarceration Rates",
    x = "Year",
    y = "Average Incarceration Rate",
    color = "Race"
  ) +
  scale_color_manual(values = c("White" = "blue", "Black" = "red")) +
  facet_wrap(~state, ncol = 2, scales = "free_x") +
  theme_minimal()

print(chart2)
