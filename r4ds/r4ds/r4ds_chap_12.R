library(tidyverse)

# tidy data ----
table1

table1 %>%
  mutate(rate = cases/population*10000)

table1 %>%
  count(year, wt = cases)

ggplot(table1, aes(year, cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country))

# exercises

# 2 

table2_cases <- table2 %>%
  filter(type == 'cases') %>%
  arrange(country,year)

table2_pop <- table2 %>%
  filter(type == 'population') %>%
  arrange(country, year)

table2_cases_rate <- tibble(
  
  year = table2_cases$year,
  country = table2_cases$country,
  cases = table2_cases$count,
  population = table2_pop$count
) %>%
  mutate(cases_per_capta = (cases/population)*10000) %>%
  select(country, year, cases_per_capta)

table2_cases_rate <- table2_cases_rate %>%
  mutate(type = "cases_per_capta") %>%
  rename(count = cases_per_capta)

bind_rows(table2, table2_cases_rate) %>%
  arrange(country, year, type, count)


# pivoting ----


table4a %>%
  pivot_longer(c(`1999`,`2000`), names_to = "year", values_to = "cases")


# separating and uniting ----

table3

table3 %>%
  separate(rate, into = c("cases", "population"))


table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/")

table3 %>%
  separate(rate, into = c("cases", "population"), convert = TRUE)

# unite ----

table5 %>%
  unite(new, century, year)

table5 %>%
  unite(new, century, year, sep = "")


table5 %>%
  unite(new, century, year, sep = "")

# exercises ----

# 1 

?separate
# using extra
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "drop")

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

# using fill
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = "right")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = "left")

# 2
?unite

# the remove argument will drop the input columns from the
# resulting dataframe. It may be useful to keep it if one 
# intend to use it again

# 3
?separate

# missing values ----

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks %>% 
  pivot_wider(names_from = year, values_from = return)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(
    cols = c(`2015`,`2016`),
    names_to = "year",
    values_to = "return",
    values_drop_na = TRUE
  )

iris %>%
  filter(!is.na(Sepal.Length))

# case study ----












