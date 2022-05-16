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
