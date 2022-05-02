library(tidyverse)

# choose the .csv file that stores financial data
fin_data <- read_csv(file.choose())

unique(fin_data$Industry)

# changing from non-factor to factor

fin_data$ID <- factor(fin_data$ID)
fin_data$Inception <- factor(fin_data$Inception)
fin_data

# gsub and sub
fin_data$Expenses <-gsub(" Dollars","",fin_data$Expenses)
fin_data$Expenses <-gsub(",","",fin_data$Expenses)

fin_data$Revenue <-gsub("\\$","",fin_data$Revenue)
fin_data$Revenue <-gsub(",","",fin_data$Revenue)

fin_data$Growth <- gsub("%", "", fin_data$Growth)
#fin_data$Growth <- gsub("-", "", fin_data$Growth)

str(fin_data)

fin_data$Expenses <- as.numeric(fin_data$Expenses)
fin_data$Revenue <- as.numeric(fin_data$Revenue)
fin_data$Growth <- as.numeric(fin_data$Growth)
str(fin_data)

# dealing with NAs

complete.cases(fin_data)
fin_data[complete.cases(fin_data),]

fin_data <- read_csv(file.choose(), na = c(""))
head(fin_data,20)

