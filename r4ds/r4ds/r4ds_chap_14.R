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