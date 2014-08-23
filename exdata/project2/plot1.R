NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

PM25 = subset(NEI, Pollutant=='PM25-PRI')

png(width=480, height=480);
results <- sapply(split(PM25$Emissions, PM25$year), sum, na.rm = TRUE)
plot(labels(results), results, 
     type='l',
     ylab='Total Emissions',
     xlab='Year'
     )



