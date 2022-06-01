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


