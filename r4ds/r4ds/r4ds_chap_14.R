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

# matching patterns with regular expressions ----

x <- c("apple", "banana", "pear")

str_view(x, "an")
str_view(x, ".a.")

# exercises ---- 

# reread the 14.3 section

# 1
x <- "\\"

str_view(x, "\\")


# 2


# 3

# anchors ----
library(tidyverse)
x <- c("apple", "banana", "pear")
str_view(x, "^a") # match the start of the string
str_view(x, "a$") # match the end of the string


x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")


# exercises ----

# 1

# 2

str_view(stringr::words, "^y", match = TRUE)
str_view(stringr::words, "x$", match = TRUE)
str_view(stringr::words, "^...$", match = TRUE)
str_view(stringr::words, ".......", match = TRUE)

# character classes and alternatives ----

# \d - matches any digit
# \s - matches any whitespace (space, tab, newline)
# [abc] - matches a, b or c
# [^abc] - matches anything, except a, b or c

# Remember, to create a regular expression containing \d or \s, you’ll need to 
# escape the \ for the string, so you’ll type "\\d" or "\\s".

# A character class containing a single character is a nice alternative to 
# backslash escapes when you want to include a single metacharacter in a regex. 
# Many people find this more readable.

str_view(c("abc", "a.c", "a*c", "a c"), "a[*]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")

# ] \ - and ^ must be handled with backlash spaces

# exercises ----

# 1

str_view(stringr::words, "^[aeiou]", match = TRUE)
str_view(stringr::words, "[aeiou]", match = FALSE)
str_view(stringr::words, "[^e]ed$", match = TRUE)
str_view(stringr::words, "i(ng|se)$", match = TRUE)

# 2
str_view(stringr::words, ".ic.", match = TRUE)

# 3
str_view(stringr::words, ".q[^u].", match = TRUE)

# 4

print("What ?")

# 5

# phone number in Brazil
str_view(stringr::words, "[(][\d\d][)][\d\d\d\d\d\d\d\d\d]")

# repetition ----

# ? - 0 or 1 occurrences
# + - 1 or more occurrences
# * - 0 or more occurrences

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")

# You can also specify the number of matches precisely:
# {n} - exactly n
# {n,} - n or more
# {,m} - at most m
# {n,m} - between n and m

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,5}")

# exercises ----

# 1
# the equivalent of ? is {0,1} - 0 or 1 occurrences
# the equivalent of + is {1,} - 1 or more occurrences
# the equivalent of * is {0,} - 0 or more occurrences

# ? - 0 or 1 occurrences
# + - 1 or more occurrences
# * - 0 or more occurrences

# 2

# 3

str_view(stringr::words, "^[^aeiou]{3}", match = TRUE)
str_view(stringr::words, "[aeiou]{3}", match = TRUE)
str_view(stringr::words, "[aeiou]{1}[^aeiou]{1}[aeiou]{1}[^aeiou]{1}", match = TRUE)

# grouping and backreferences ----

str_view(fruit, "(..)\\1", match = TRUE)

# exercises ----

str_view(fruit, "(.)\1\1", match = TRUE)

# tools ----

# detect matches ----

x <- c("apple", "banana", "pear")
str_detect(x, "e")

# how many words start with t?
sum(str_detect(words, "^t"))

# what proportion of common words end with a vowel?
mean(str_detect(words,"[aeiou]$"))

# it's easy to get complicated regular expression, therefore try to combine
# different functions to achieve what you need

# find all words containing at least one vowel, and negate
no_vowels_1 <- !str_detect(words, "[aeiou]")
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1,no_vowels_2)

words[str_detect(words,"x$")]
str_subset(words, "x$")


df <- tibble(
  word = words,
  i = seq_along(word)
)

df %>%
  filter(str_detect(word, "x$"))

x <- c("apple", "banana", "pear")
str_count(x, "a")
str_count(x, "b")

mean(str_count(words,"[aeiou]"))

df %>%
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

str_count("abababa", "aba")
str_view_all("abababa", "aba")

# exercises ----

# 1

words[str_detect(words, "x$|^x")]
x_start <- str_detect(words, "^x")
x_end <- str_detect(words, "x$")
x_words <- words[x_start|x_end]
x_words

words[str_detect(words, "^[aeiou].*[^aeiou]$")]
vow_start <- str_detect(words, "^[aeiou]")
cons_end <- str_detect(words, "[^aeiou]$")
words_result <- words[vow_start & cons_end]
words_result

# extract matches ----


