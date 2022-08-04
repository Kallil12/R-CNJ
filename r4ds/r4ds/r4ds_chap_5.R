library(nycflights13)
library(tidyverse)
library(Lahman)

flights

# filter, arrange, select, mutate, and summarise

# filter ----

flights %>%
  filter(month == 1, day == 1)

sqrt(2)^2 == 2

flights %>%
  filter(month == 1 | month == 12)

nov_dec <- flights %>%
  filter(month %in% c(11,12))

# arrange ----
# remember that missing values are alywas sorted at the end

arrange(flights, year, month, day)

flights %>%
  arrange(desc(dep_delay))

# select ----
# it selects columns

flights %>%
  select(year, month, day)

# it selects all columns between year and day
flights %>%
  select(year:day)

flights %>%
  select(time_hour, air_time, everything())

# mutate ----
# add new columns at the end of the dataset

flights %>%
  mutate(gain = dep_delay - arr_delay,
         speed = distance/air_time*60) %>%
  select(gain, speed, everything())

# summarise ----

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_year <- group_by(flights, year)
summarise(by_year, delay = mean(dep_delay, na.rm = TRUE))

####### mean delay by distance ####### ----

by_dest <- flights %>%
  group_by(dest)

delay <- by_dest %>%
  summarise(count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)
    ) %>% 
  filter(count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# missing values ----

flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)


### batting averages - baseball ----
#install.packages('Lahman')

batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    ba = sum(H, na.rm = TRUE)/sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE)

# useful summary functions ----

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    avg_delay_1 = mean(arr_delay),
    avg_delay_2 = mean(arr_delay[arr_delay > 0])
  )

not_cancelled %>%
  group_by(dest) %>%
  summarise(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd)
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

n_distinct(not_cancelled$carrier)

not_cancelled %>%
  count(dest)

# what proportions of flights are delayed by more than an
# hour?

not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(hour_prop = mean(arr_delay > 60))


# grouping by multiple variables ----
daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year <- summarise(per_month, flights = sum(flights)))

# ungrouping ----

flights_sml <- flights %>%
  select(year,month, day, dep_delay, arr_delay, distance, air_time)

flights_sml %>%
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)

popular_dests
