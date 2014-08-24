library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset baltimore
BALT = subset(NEI, fips=='24510')

# summarise by type and year
table <- ddply(BALT, .(type, year), summarize, sum = sum(Emissions))
png(filename = "plot3.png", width=480, height=480);

# use qplot and facet_grid (geom_smooth lm method)
qplot(year, sum, data = table) + facet_grid(type ~ .) + geom_point() + geom_smooth(method=lm) + xlab('Year') + ylab('Total Emissions') + ggtitle('PM25 Emissions in Baltimore City by type')
