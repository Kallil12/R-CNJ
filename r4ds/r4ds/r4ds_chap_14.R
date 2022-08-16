library(tidyverse)

# string basics ----

string1 <- "This is a string"
string2 <- "And this is another string with quotes \" " 
string3 <- "And this is another string with quotes"

# this is the way to see what is REALLY being saved
writeLines(string2)


micro <- "\u00b5"
writeLines(micro)

# string length ----

str_length(c("A", "R for data science", NA, "Mon cherry"))

# combining strings ----

str_c("Maria", " José")
str_c("Maria", "José", sep = " ")
str_c("x","y","z")

str_c("x", "y", "z", sep = ", ")
str_c("prefix-", c("a","b","c"),"-suffix")


name <- "Kallil"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if(birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(c("Daniel","Matheus","Juliana"), collapse = ", ")

# subsetting strings ----

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

# locales ----

x <- c("apple", "orange", "watermelon", "banana")
str_sort(x, locale = "en")

# exercises ----

# 1 
?paste
?paste0

paste("joao","maria", "paulo", "ricardo") # a space between strings
paste0("joao","maria", "azul", "amarelo") # no spaces between strings

# 2

?str_c
str_c("x", "y", "z", sep = ", ")
str_c("x", "y", "z", sep = " aehoo ", collapse = TRUE)

# 3

str_length("abcde")
str_sub("abcde",3,3)

str_length("abcdef")
str_sub("abcdef",3,4)

# when the string has an even number of characters I will 
# extract the two characters that are in the middle

# 4

?str_wrap
tests <- "testing some stuff around here"
cat(str_wrap(tests, width = 2, exdent = 0), "ahoy")

# 5

?str_trim
spacey_string <- "  this is a string with many spaces     "
str_trim(spacey_string)

print("The opposite of str_trim is str_pad")
?str_pad

str_pad("this is something", 35, side = "both", pad = "-")
str_pad("a", 10, pad = c("-", "_", " "))

# 6

# matching patterns with regular expressions
