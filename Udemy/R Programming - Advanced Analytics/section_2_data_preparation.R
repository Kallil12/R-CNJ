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

fin_data[fin_data$Revenue == 9746272,]

# using the "which" operator

which(fin_data$Revenue == 9746272)
fin_data[which(fin_data$Revenue == 9746272),]

fin_data[which(fin_data$Employees == 45),]

# filtering NAs - using is.na()

a <- c(1,24,53,NA,76,55,NA)
is.na(a)

is.na(fin_data$Expenses)
fin_data[is.na(fin_data$Expenses),]

# removing records with missing data
fin_backup <- fin_data

fin_data[!complete.cases(fin_data),]
fin_data[is.na(fin_data$Industry),]

fin_data <- fin_data[!is.na(fin_data$Industry),]

# reseting dataframe index

rownames(fin_data) <- 1:nrow(fin_data)

# replacing data - factual analysis method

fin_data[is.na(fin_data$State) & fin_data$City == "New York","State"] <- "NY"
fin_data[c(11,377),]

fin_data[is.na(fin_data$State) & fin_data$City == "San Francisco","State"] <- "SF"
fin_data[c(82,265),"State"] <- "CA"
fin_data[c(82,265),]

fin_data[!complete.cases(fin_data),]


# median imputation method part I

median(fin_data$Employees, na.rm = TRUE)
mean(fin_data[fin_data$Industry == "Retail", "Employees"], na.rm = TRUE)

fin_data %>%
  filter(Industry == "Retail") %>%
  drop_na() %>%
  summarise(media = mean("Employees"))

mean(fin_data$Employees, na.rm = TRUE)
fin_retail <- fin_data[fin_data$Industry == "Retail",]
mean(fin_retail$Employees, na.rm = TRUE)
med_empl_retail <- median(fin_retail$Employees, na.rm = TRUE)

fin_data[is.na(fin_data$Employees) & fin_data$Industry == "Retail", "Employees"] <- med_empl_retail

fin_data[fin_data$Industry == "Retail",]
fin_financial <- fin_data[fin_data$Industry == "Financial Services",]
med_financial <- median(fin_financial$Employees, na.rm = TRUE)

fin_data[is.na(fin_data$Employees) & fin_data$Industry == "Financial Services", "Employees"] <- med_financial

md_growth_constr <- median(fin_data[fin_data$Industry == "Construction", "Growth"], na.rm = TRUE)


fin_data %>%
  filter(Industry == "Construction") %>%
  drop_na(Revenue) %>%
  summarise(media = mean("Revenue"))

?gsub
?sub
