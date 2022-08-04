library(tidyverse)

# questions ----
# it is important to keep in mind that there are not rules to 
# guide a data analysis. However, two types of questions will
# always be useful for making discoveries within your data:

# 1 - what type of variation occurs within my variables?
# 2 - what type of covariation occurs between my variables?


# variation ----
# variation is the tendency of the values of a variable to 
# change from measurement to measurement

# visualising distributions ----

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

diamonds %>%
  count(cut)

# continuous variable

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

diamonds %>%
  count(cut_width(carat, 0.5))

smaller_diamonds <- diamonds %>%
  filter(carat < 3)

ggplot(data = smaller_diamonds, mapping = aes(x = carat))+
  geom_histogram(binwidth = 0.1)

ggplot(data = smaller_diamonds, mapping = aes(x = carat, color = cut))+
  geom_freqpoly(binwidth = 0.1)


# some interesting questions that should be done when 
# making an analysis:

# 1 - Which values are the most common? Why?
# 2 - Which values are rare? Why? Does that match your expectations?
# 3 - Can you see any unusual patterns? What might explain them?

# unusual values ----

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0,50))

(unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  select(price, x, y, z) %>%
  arrange(y))

str(diamonds)

# missing values ----

diamonds_2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

str(diamonds_2)

ggplot(data = diamonds_2, mapping = aes(x = x, y = y)) +
  geom_point()

nycflights13::flights %>%
  mutate(cancelled = is.na(dep_time),
         sched_hour = sched_dep_time %/% 100,
         sched_min = sched_dep_time %% 100,
         sched_dep_time = sched_hour + sched_min/60
         ) %>%
  ggplot(mapping = aes(sched_dep_time)) +
    geom_freqpoly(mapping = aes(color = cancelled), binwidth = 1/4)

# covariation ----
# if variation describes the behavior within a variable, covariation describes 
# the behavior between variables.

# a categorical and continuous variable ----

ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

ggplot(diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot() +
  coord_flip()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()+
  coord_flip()


ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

# two categorical variables ----

diamonds %>%
  arrange(cut) %>%
  count(color, cut)


diamonds %>%
  arrange(cut) %>%
  count(color, cut) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n))

# two continuous variables ----

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price), alpha = 1/100)

ggplot(data = smaller_diamonds) +
  geom_bin2d(mapping = aes(x = carat, y = price))

ggplot(data = smaller_diamonds) +
  geom_hex(mapping = aes(x = carat, y = price))

ggplot(data = smaller_diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

# patterns and models ----

ggplot(data = faithful, mapping = aes(x = eruptions, y = waiting)) +
  geom_point(alpha = 0.5)


####
mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds_2 <- diamonds %>%
  add_residuals(mod) %>%
  mutate(resid = exp(resid))

ggplot(data = diamonds_2) +
  geom_point(mapping = aes(x = carat, y = resid))

### the analysis above is not clear to me

# ggplot2 calls ----

ggplot(data = faithful, mapping = aes(x = eruptions)) +
  geom_freqpoly(binwidth = 0.25)

ggplot(faithful, aes(eruptions)) +
  geom_freqpoly(binwidth = 0.25)

diamonds %>%
  count(cut, clarity) %>%
  ggplot(aes(clarity, cut, fill = n)) +
  geom_tile()









