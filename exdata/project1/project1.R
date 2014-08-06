library("data.table")
data <- fread("household_power_consumption.txt", na.strings="?")
data[,Date] <- strptime(data[,Date], format="%d/%m/%Y")


