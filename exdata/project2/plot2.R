library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset for baltiore
BALT = subset(NEI, fips=="24510")

# summarise per year and set device to png
table <- ddply(BALT, .(year), summarize, sum = sum(Emissions))
png(filename="plot2.png", width=480, height=480);
plot(table$year, table$sum, 
     ylab='Total Emissions',
     xlab='Year'
     )
title(main='PM25 Emissions in Baltimore City')
abline(lm(table$sum ~ table$year))
