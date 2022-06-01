library(tidyverse)
rm(list = ls())

chicago <- read.csv("Chicago-F.csv", row.names = 1)
# chicaco <- read.csv(file.choose())
houston <- read.csv("Houston-F.csv", row.names = 1)
ny <- read.csv("NewYork-F.csv", row.names = 1)
sf <- read.csv("SanFrancisco-F.csv", row.names = 1)

chicago_matrix <- as.matrix(chicago)
houston_matrix <- as.matrix(houston)
ny_matrix <- as.matrix(ny)
sf_matrix <- as.matrix(sf)

weather <- list(chicago = chicago_matrix, 
                houston = houston_matrix,
                ny = ny_matrix,
                sf = sf_matrix)

weather

# using apply
apply(chicago_matrix, 1, mean)
mean(chicago_matrix["DaysWithPrecip",])
apply(chicago_matrix, 1, max)
apply(chicago_matrix, 1, min)

apply(chicago_matrix, 1, mean)
apply(houston_matrix, 1, mean)
apply(ny_matrix, 1, mean)
apply(sf_matrix, 1, mean)

# recreating the apply function with loops
output <- NULL
for(i in 1:5){
  output[i] <- mean(chicago_matrix[i,])
}

names(output) <- rownames(chicago_matrix)

lapply(weather, t)
lapply(weather, rbind, NewRow = 1:12)

#rowMeans(chicago_matrix)
lapply(weather, rowMeans)

# lapply and []

lapply(weather, "[", 1,)
weather

lapply(weather, "[",,3)

# adding functions
lapply(weather, rowMeans)
lapply(weather, function(x) x[1,])

lapply(weather, function(z) z[1,]-z[2,])

# sapply()
?sapply
lapply(weather,"[",1,7)
sapply(weather,"[",1,7)

sapply(weather,"[",1,10:12)
sapply(weather, rowMeans)
round(sapply(weather, rowMeans),2)

sapply(weather, function(z) round((z[1,]-z[2,])/z[2,],2))
