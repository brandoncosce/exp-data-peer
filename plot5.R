dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

NEIsub <- NEI[NEI$fips == "24510",]
SCCv <- SCC[grep("Vehicles",SCC$EI.Sector),"SCC"]
NEIsubv <- NEIsub[NEIsub$SCC %in% SCCv,]

NEIsubv <- NEIsubv %>% group_by(year)
NEIsubvsum <- NEIsubv %>% summarise(sumEmissions = sum(Emissions))

png("./plots/plot5.png")
qplot(NEIsubvsum$year,NEIsubvsum$sumEmissions,geom = "line", xlab = "Year", ylab = "Total Motor Vehicle Emmissions in Baltimore City (Tons")
dev.off()