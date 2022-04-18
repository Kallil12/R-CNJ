library(nycflights13)
library(tidyverse)

flights %>%
  filter(month == 1, day == 12)

jan_12 <- flights %>%
  filter(month == 1, day == 12)

nov_dec <- flights %>%
  filter(month == 11 | month == 12)

# exercises - 5.2.4