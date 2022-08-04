1/200*30

(59 + 73 + 2)/3

# try to use snake_case all the time, its a good
# practice to keep it consistent

seq(1,10)
seq(1,10,0.01)
seq(1,10,0.5)

test <- "hello world"
test

##################################

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)
###################################

