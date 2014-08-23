library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# To get the relevant data I'm getting the SCC index for 
# Mobile - On-Road from EI.Sector
vehindex <- grep("Mobile - On-Road", SCC$EI.Sector)
SCCData <- SCC$SCC[vehindex]
MOTORBALT <- subset(NEI, SCC %in% SCCData & fips=='24510')
# Summarise in 'table' by summing Emissions
table <- ddply(MOTORBALT, .(year), summarize, sum = sum(Emissions))

png(filename = "plot5.png", width=480, height=480);

qplot(year, sum, data=table) + geom_line() + ylab("Total Emissions") + xlab("Year") + ggtitle("PM25 Emissions from Motor Vehicle Sources")

