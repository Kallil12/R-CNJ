library(nycflights13)
library(tidyverse)

flights %>%
  filter(month == 1, day == 12)

jan_12 <- flights %>%
  filter(month == 1, day == 12)

nov_dec <- flights %>%
  filter(month %in% c(11,12))

flights %>%
  filter(is.na(month))

flights[!complete.cases(flights),]

# the five functions:
# filter()
# arrange()
# select()
# mutate()
# summarise()

# exercises - 5.2.4


