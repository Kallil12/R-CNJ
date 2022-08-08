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


