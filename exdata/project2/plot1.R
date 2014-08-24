library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set png device
png(filename="plot1.png", width=480, height=480);

# summarize data using ddply per year
table <- ddply(NEI, .(year), summarize, sum = sum(Emissions))
plot(table$year, table$sum, 
     ylab='Total Emissions',
     xlab='Year'
     )
title(main='PM25 Emissions')
abline(lm(table$sum ~ table$year))



