library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BALT = subset(NEI, fips=='24510')

table <- ddply(BALT, .(type, year), summarize, sum = sum(Emissions))

png(filename = "plot3.png", width=480, height=480);

qplot(year, sum, data = table, type ='l') + facet_grid(type ~ .) + geom_line()
