library("data.table")
data <- fread("household_power_consumption.txt", na.strings="?", sep=';', select=c('Date', 'Time', 'Global_active_power', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3', 'Voltage', 'Global_reactive_power'), showProgress = TRUE)
interesting_dates <- c('1/2/2007', '2/2/2007')

png(filename = "plot4.png",
    width = 480, height = 480)

use_data <- subset(data, Date %in% interesting_dates)
use_data <- transform(use_data, Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3), Voltage = as.numeric(Voltage), Global_reactive_power = as.numeric(Global_reactive_power), TS = as.POSIXct(strptime(paste(Date, Time, sep=" "), format='%d/%m/%Y %H:%M:%S')))

par(mfrow=c(2,2))

plot(use_data$TS, use_data$Global_active_power,
 type = 'l',
 xlab = '',
 main = '',
 ylab = 'Global Active Power'
)

plot(use_data$TS, use_data$Voltage,
 type = 'l',
 xlab = 'datetime',
 main = '',
 ylab = 'Voltage'
)



plot(use_data$TS, use_data$Sub_metering_1,
 col  = 'black',
 type = 'l',
 xlab = '',
 main = '',
 ylab = 'Energy sub metering'
)
lines(use_data$TS, use_data$Sub_metering_2,
 col  = 'orange',
)
lines(use_data$TS, use_data$Sub_metering_3,
 col  = 'blue',
)

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=c(1,1), col=c('black', 'orange', 'blue'))

plot(use_data$TS, use_data$Global_reactive_power,
 type = 'l',
 xlab = 'datetime',
 main = '',
 ylab = 'Global reactive power'
)


