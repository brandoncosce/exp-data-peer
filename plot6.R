dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

NEIsub <- NEI[NEI$fips %in% c("24510","06037"),]
SCCv <- SCC[grep("Vehicles",SCC$EI.Sector),"SCC"]
NEIsubv <- NEIsub[NEIsub$SCC %in% SCCv,]

NEIsubv <- NEIsubv %>% group_by(year,fips)
NEIsubvsum <- NEIsubv %>% summarise(sumEmissions = sum(Emissions))

png("./plots/plot6.png")
#qplot(NEIsubvsum$year,NEIsubvsum$sumEmissions, geom = "line",  xlab = "Year", ylab = "Motor Vehicle Emissions (Sum)", facets = NEIsubvsum$fips)
g <- ggplot(data = NEIsubvsum, aes(NEIsubvsum$year,NEIsubvsum$sumEmissions)) + xlab("Year") + ylab("Total Emissions (Tons)")
g + geom_line() + facet_grid(cols = vars(NEIsubvsum$fips))
dev.off()