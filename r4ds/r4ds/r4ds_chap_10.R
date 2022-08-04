library(tidyverse)

# creating tibbles ----
as_tibble(iris)

tibble(
  id_car = 1:5,
  brand = "Volkswagen",
  model = c("UP!", "Polo", "Golf", "Tiguan", "TRoc"),
  price = id_car^2
)

# tibble allows some weird column names

tb <- tibble(
  `:)` = "Smile",
  ` ` = "Space",
  `2000` = "A number"
)

#tb

tribble(
  ~brand, ~model, ~price, ~id_car,
  #-----#-------#-------#---------
  "Porsche", "911", 150000, 5,
  "Audi", "RS3", 85000, 5
)

# tibble vs data.frame ----

tibble(
  
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>%
  print(n = 10, width = Inf)

# subsetting ----

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x

df[["x"]]

df[[1]]

# interacting with older code ----

class(as.data.frame(tb))

# exercises ----

# 1
# using the function str()
str(mtcars)

# 2

df <- data.frame(abc = 1, xyz = "a")
df$x
df[,"xyz"]
df[, c("abc","xyz")]

# I believe that the tibble structure is more concerned
# with possible typos, so it is more restrict about how
# to interact with rows and columns names

# 3 
var <- "mpg"

# 4
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
# 4.1

annoying$"1"
annoying[["1"]]


ggplot(annoying,aes(.data[["1"]],.data[["2"]])) +
  geom_point()

annoying[["3"]] <- annoying[["2"]]/annoying[["1"]]

# 5 
?enframe
# it converts vectors to data frames, and vice versa
# it can be useful in operations that result in vectors
# but the values will be aggregated in a tibble













