dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(dplyr)

NEI <- NEI %>% group_by(year)
sn <- NEI %>% summarise(total_emmissions = sum(Emissions))

dir.create("plots")
png("./plots/plot1.png")
plot(sn$year,sn$total_emmissions)
dev.off()