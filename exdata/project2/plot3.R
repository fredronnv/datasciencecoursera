library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

PM25 = subset(NEI, fips=='24510')

t <- ddply(PM25, .(type, year), summarize, sum = sum(Emissions))
print(t)
#png(width=480, height=480);

#qplot(total, year, data = t) + facet_grid(. ~ type)


