dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

SCCcoal <- SCC[grep("Coal", SCC$EI.Sector),"SCC"]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal,]


NEIcoal <- NEIcoal %>% group_by(year)
NEIcTable <- NEIcoal %>% summarise(EMmean = sum(Emissions))

dir.create("plots")
png("./plots/plot4.png")
qplot(NEIcTable$year,NEIcTable$EMmean,geom = "line", xlab = "Year", ylab = "Total Coal Emmissions (Tons)")
dev.off()