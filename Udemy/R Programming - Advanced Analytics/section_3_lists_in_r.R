machines <- read_csv(file.choose())
head(machines, 12)
str(machines)
summary(machines)

head(machines,20)

# Derive utilization column

machines$Utilization = 1 - machines$`Percent Idle`

head(machines,20)
tail(machines,20)
?POSIXct

machines$PosixTime <- as.POSIXct(machines$Timestamp, format = "%d/%m/%Y %H:%M")

head(machines,20)

# tip: how to rearrange columns in a tibble:
machines$Timestamp <- NULL
machines <- machines[,c(4,1,2,3)]
head(machines, 10)

RL1 <- machines[machines$Machine == "RL1",]
head(RL1,20)

# Construct a list with:
# Char: machine name
# Vector: min, mean, and max utilization for the month (excluding unknown hours)
# Logical: has utilization fallen below 90%? TRUE/FALSE

machine_RL1 <- c(min(RL1$Utilization, na.rm = T), 
                 mean(RL1$Utilization, na.rm = T), 
                 max(RL1$Utilization, na.rm = T))
machine_RL1

which(RL1$Utilization < 0.90)
machines_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0

list_rl1 <- list("RL1", machine_RL1, machines_under_90_flag)
list_rl1

names(list_rl1) <- c("Machine", "Stats", "LowThreshold")

# extracting components of a list:
# [], [[]] or $

list_rl1

list_rl1[1]

list_rl1[[1]]

list_rl1$Machine

typeof(list_rl1[[2]])
typeof(list_rl1$Stats)

list_rl1$Stats[3]

list_rl1[4] <- "New Information"

list_rl1

# add:
# vector: all hours where utilization is inknown (NA's)

list_rl1$UnkownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]

list_rl1[4] <- NULL

# add another component
# dataframe

list_rl1$Data <- RL1

# subsetting a list

list_rl1$UnkownHours[1]

# creating a timeseries plot

p <- ggplot(data = machines)
myplot <- p + geom_line(aes(x = PosixTime, y = Utilization,
                  color = Machine), size = 1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90,
             color = "Gray", 
             size = 1.1,
             linetype = 3)

list_rl1$Plot <- myplot
list_rl1

summary(list_rl1)





