dir.create("data")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(dplyr)

NEI <- NEI %>% group_by(year)
NEIb <- NEI[NEI$fips == "24510",]
sn <- NEIb %>% summarise(total_emissions = sum(Emissions))

dir.create("plots")
cols <- c(1,6,3,4)
png("./plots/plot2.png")
plot(sn$year,sn$total_emissions, pch = 19, col = cols)
legend("topright", legend = sn$year, col = cols, pch = 19)
abline(lm(sn$total_emissions ~ sn$year), col = "red")
dev.off()
