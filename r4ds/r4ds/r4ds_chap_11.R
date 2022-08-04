library(tidyverse)

diamonds_1 <- read_csv("diamonds.csv")

read_csv("The first line of metadata
         and this is the second line of metadata
         x,y,z
         1,2,3", skip = 2)

read_csv("? A comment that I want to skip
         x,y,z
         1,2,3", comment = "?")

# exercises ----

# 1
?read_delim
# so, to add the custom separator, "|" in our case, the function 
# read_delim(data = <DATA>, delim = "|") can be used

# 2
?read_tsv()
?read_csv()

# 3
?read_fwf()

# 4 
?read_csv
read_csv("x,y\n1,'a,b'", quote = "\'")

# 5
# 5.1 
read_csv("a,b,c\n1,2,3\n4,5,6")

# 5.2
read_csv("a,b,c\n1,2\n1,2,3,4")

# the problem in this case is related to the number of
# columns and variables - 2 columns and 4 variables in the 
# second line of data

# 5.5
read_csv2("a;b\n1;3")

# parsing a vector ----

str(parse_logical(c("TRUE","FALSE","NA")))
str(parse_date(c("2010-01-01", "1979-10-14")))

parse_integer(c("1","231",".", "456"), na = ".")

x <- parse_integer(c("123", "345", "abc", "123.45"))

problems(x)


# numbers ----

parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")

parse_number("$123,456,789")
parse_number("123.456.789", locale = locale(grouping_mark = "."))
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

# strings ----

charToRaw('Kallil')

# dates, date-times, and times ----
parse_datetime("2010-10-01T2010")
parse_datetime("20101001")

parse_date("2010-12-31")
parse_date("2010/12/31")

parse_date("2010-12-31") == parse_date("2010/12/31")

library(hms)

parse_time("20:10:01")

# exercises ----

# 1
?locale()
# date_names and encoding

# 2

# 5
?read_csv()
?read_csv2()

# 7

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014
t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1,"%B %d, %Y")
parse_date(d2,"%Y-%b-%d")
parse_date(d3,"%d-%b-%Y")
parse_date(d4,"%B %d %.%Y%.")
parse_date(d5,"%m/%d/%y")
parse_time(t1,"%H%M")
parse_time(t2,"%I:%M:%OS %p")

# parsing a file ----

guess_parser("1992-01-12")
guess_parser("Kallil")
guess_parser(c(1,5,66,87))

challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
problems(challenge)
tail(challenge)

df <- tribble(
  ~x, ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)

df
type_convert(df)

# writing to a file ----

write_csv(challenge, "challenge.csv")
read_csv("challenge.csv")

# csv files can be unreliable sometimes, so to fix it
# we can use .RDS files. This is R's custom binary format

write_rds(challenge, "challenge.rds") 
read_rds("challenge.rds")

install.packages("feather")
library(feather)

write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")

