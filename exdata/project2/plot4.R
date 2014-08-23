library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combindex <- grep("Combustion", SCC$SCC.Level.One)
coalindex <- grep("Coal", SCC$SCC.Level.Three)
bothindex <- intersect(combindex,coalindex)
SCCData <- SCC$SCC[bothindex]

COALCOMB <- subset(NEI, SCC %in% SCCData)
table <- ddply(COALCOMB, .(year), summarize, sum = sum(Emissions))

png(filename = "plot4.png", width=480, height=480);

qplot(year, sum, data=table) + geom_line()


