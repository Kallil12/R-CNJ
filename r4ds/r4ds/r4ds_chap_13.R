library(tidyverse)
library(nycflights13)


# nycflighits13 ----
airlines
airports
planes
weather

planes %>%
  arrange(-year)

# exercises ----

# 1

# the table "flights" shows "origin" and "dest" columns, which
# represent the origin and destination of each flight.
# Therefore, no table combination is needed.

# 2

airports %>%
  filter(faa %in% c("EWR","JFK","LGA"))

unique(weather$origin)

# the relation between "airports" and "weather" is 
# between the string code.
# airports$faa <-> weather$origin


# keys ----

planes %>%
  count(tailnum) %>%
  filter(n > 1)

weather %>%
  count(year, month, day, hour, origin) %>%
  filter(n > 1)

flights %>%
  count(year, month, day, flight) %>%
  filter(n > 1)


# exercises ----

flights %>%
  arrange(year, month, day, tailnum, carrier, flight) %>%
  mutate(flight_id = row_number()) %>%
  count(flight_id) %>%
  filter(n > 1)


# mutating joins ----

flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2

flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")


# both flights2 and airlines have a column named "carrier"
# so the join operation is a little bit different from
# what is seem on SQL

head(flights2)
head(airlines)

# understanding joins ----

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# inner join ----

x %>%
  inner_join(y, by = "key")

# outer joins ----

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)

left_join(x,y,by = "key")

# defining the key columns ----

flights2 %>%
  left_join(weather)

flights2 %>%
  left_join(airports, c("dest" = "faa"))

# exercises ----

airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
    borders("state") +
    geom_point() +
    coord_quickmap()

avg_dest_delays <- flights %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c(dest = "faa")) 

avg_dest_delays %>%
  ggplot(aes(lon, lat, color = delay)) +
  borders("state") + 
  geom_point() +
  coord_quickmap()

# 2 add the location of the origin and destination to flights

airport_locations <- airports %>%
  select(faa, lat, lon)

flights %>%
  select(year:day, hour, origin, dest) %>%
  left_join(
    airport_locations,
    by = c("origin" = "faa")
  ) %>%
  left_join(
    airport_locations,
    by = c("dest" = "faa")
  )

airport_locations <- airports %>%
  select(faa, lat, lon)

flights %>%
  select(year:day, hour, origin, dest) %>%
  left_join(
    airport_locations, 
    by = c("origin" = "faa")
  ) %>%
  left_join(
    airport_locations,
    by = c("dest" = "faa"),
    suffix = c("_origin", "_dest")
  )

# is there a relationship between the age of a plane and its delays?

plane_cohorts <- inner_join(flights,
                            select(planes, tailnum, plane_year = year),
                            by = "tailnum"
                ) %>%
  mutate(age = year - plane_year) %>%
  filter(!is.na(age)) %>%
  mutate(age = if_else(age > 25, 25L, age)) %>%
  group_by(age) %>%
  summarise(
    dep_delay_mean = mean(dep_delay, na.rm = TRUE),
    dep_delay_sd = sd(dep_delay, na.rm = TRUE),
    arr_delay_mean = mean(arr_delay, na.rm = TRUE),
    arr_delay_sd = sd(arr_delay, na.rm = TRUE),
    n_arr_delay = sum(!is.na(arr_delay)),
    n_dep_delay = sum(!is.na(dep_delay))
  )

ggplot(plane_cohorts, aes(x = age, y = dep_delay_mean)) +
  geom_point() +
  scale_x_continuous("Planes' age (years)", breaks = seq(0,30, by = 10)) +
  scale_y_continuous("Mean departure delay (minutes)")

ggplot(plane_cohorts, aes(x = age, y = arr_delay_mean)) +
  geom_point() +
  scale_x_continuous("Planes' age (years)", breaks = seq(0,30, by = 10)) +
  scale_y_continuous("Mean departure delay (minutes)")

# what weather conditions make it more likely to see a delay?

flight_weather <- flights %>%
  inner_join(weather, by = c("origin" = "origin", 
                             "year" = "year", 
                             "month" = "month", 
                             "day" = "day", 
                             "hour" = "hour"))

flight_weather %>%
  group_by(precip) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = precip, y = delay)) +
  geom_line() + geom_point()


flights %>%
  filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  ggplot(aes(y = lat, x = lon, size = delay, colour = delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# filtering joins


