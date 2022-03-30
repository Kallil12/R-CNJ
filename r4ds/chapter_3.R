library(tidyverse)
library(Hmisc)

# a graphing template:
# ggplot(data = <DATA>) +
# <GEOM_FUNCTION)(mapping = aes(<MAPPINGS))

# 3.2.4 exercises

print("3.2.4 - Exercises")
print("1")

ggplot(data = mpg)
# it only shows a blank graph because there is not mapping. No X
# or Y associated with the variables

print("2")
mpg
print("a tibble 234x11, therefore 234 lines and 11 columns")

print("3")
?mpg
print("drv describes the type of drivetrain. If it is front, rear or all wheel drive.")

print("4")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

print("5")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = class))

print("both axis are formed by categorical data, so it is not very useful to compare them because they overlap each other")
