# Filter the data for Washington state and select the top 5 counties with the highest average Black Prison Population Rate
top_5_black_counties <- prison_rate %>%
  filter(state == "WA") %>%
  group_by(county_name) %>%
  summarize(avg_black_prison_rate = mean(black_prison_pop_rate, na.rm = TRUE)) %>%
  arrange(desc(avg_black_prison_rate)) %>%
  top_n(5)

# Filter the data for the top 5 counties and plot the trend over time
top_5_county_names <- top_5_black_counties$county_name

chart1 <- ggplot(prison_rate %>% filter(state == "WA" & county_name %in% top_5_county_names), aes(x = year, y = black_prison_pop_rate, group = county_name, color = county_name)) +
  geom_line() +
  labs(title = "Trend of Black Prison Population Rate in Top 5 Counties of Washington State",
       x = "Year",
       y = "Black Prison Population Rate",
       color = "County Name") +
  theme_minimal()
print(chart1)
