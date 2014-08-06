library("data.table")
data <- fread("household_power_consumption.txt", na.strings="?", sep=';', select=c('Date', 'Global_active_power'), showProgress = TRUE)
interesting_dates <- c('1/2/2007', '2/2/2007')

png(filename = "plot1.png",
    width = 480, height = 480)

use_data <- subset(data, Date %in% interesting_dates)
use_data <- transform(use_data, Global_active_power = as.numeric(Global_active_power))
hist(use_data[,Global_active_power],
     col=c('red'),
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)',
     ylab='Frequency'
     )
