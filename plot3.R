dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

NEIsub <- NEI[NEI$fips == "24510",]
NEIsub <- NEIsub %>% group_by(year,type)
sn <- NEIsub %>% summarise(total_emissions = sum(Emissions))


dir.create("plots")
png("./plots/plot3.png")
g<- ggplot(data = sn, aes(year,total_emissions))
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm")
dev.off()

                                