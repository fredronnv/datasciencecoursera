library("ggplot2")
library("plyr")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the index of combustion and coal
combindex <- grep("Combustion", SCC$SCC.Level.One)
coalindex <- grep("Coal", SCC$SCC.Level.Three)

# get where these intersect
bothindex <- intersect(combindex,coalindex)
SCCData <- SCC$SCC[bothindex]

# subset based on the above gathered information
COALCOMB <- subset(NEI, SCC %in% SCCData)

# summarize per year
table <- ddply(COALCOMB, .(year), summarize, sum = sum(Emissions))

png(filename = "plot4.png", width=480, height=480);

qplot(year, sum, data=table) + geom_point() + geom_smooth(method=lm) + xlab('Year') + ylab('Total Emissions') + ggtitle('PM25 Emissions from coal related combustion sources')


