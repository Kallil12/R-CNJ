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


