library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BALT = subset(NEI, fips=="24510")
table <- ddply(BALT, .(year), summarize, sum = sum(Emissions))
png(filename="plot2.png", width=480, height=480);

plot(table$year, table$sum, 
     type='l',
     ylab='Total Emissions',
     xlab='Year'
     )

