library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehindex <- grep("Motor Vehicles", SCC$SCC.Level.Three)
SCCData <- SCC$SCC[bothindex]

MOTORBALT <- subset(NEI, SCC %in% SCCData, fips=='24510')
table <- ddply(MOTORBALT, .(year), summarize, sum = sum(Emissions))

png(filename = "plot5.png", width=480, height=480);

qplot(year, sum, data=table) + geom_line()

