library(plyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(filename="plot1.png", width=480, height=480);
table <- ddply(NEI, .(year), summarize, sum = sum(Emissions))
plot(table$year, table$sum, 
     type='l',
     ylab='Total Emissions',
     xlab='Year'
     )



