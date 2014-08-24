library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# To get the relevant data I'm getting the SCC index for 
# Mobile - On-Road from EI.Sector
vehindex <- grep("Mobile - On-Road", SCC$EI.Sector)
SCCData <- SCC$SCC[vehindex]
MOTORMULTI <- subset(NEI, SCC %in% SCCData & fips %in% c('24510','06037'))
# Summarise in 'table' by summing Emissions
table <- ddply(MOTORMULTI, .(year,fips), summarize, sum = sum(Emissions))

# Let's use factor to make the plot more readable
table$fips <- factor(table$fips,labels=c('Los Angeles County','Baltimore City'))

png(filename = "plot6.png", width=480, height=480);
qplot(year, sum, data=table) + facet_grid(.~fips) + geom_point() + geom_smooth(method=lm) + ylab("Total Emissions") + xlab("Year") + ggtitle("PM25 Emissions from Motor Vehicle Sources")
