library("data.table")
data <- fread("household_power_consumption.txt", na.strings="?", sep=';', select=c('Date', 'Time', 'Global_active_power'), showProgress = TRUE)
interesting_dates <- c('1/2/2007', '2/2/2007')

png(filename = "plot2.png",
    width = 480, height = 480)

use_data <- subset(data, Date %in% interesting_dates)
use_data <- transform(use_data, Global_active_power = as.numeric(Global_active_power), TS = as.POSIXct(strptime(paste(Date, Time, sep=" "), format='%d/%m/%Y %H:%M:%S')))

plot(use_data$TS, use_data$Global_active_power,
 type = 'l',
 xlab = '',
 main = '',
 ylab = 'Global Active Power (kilowatts)'
)


