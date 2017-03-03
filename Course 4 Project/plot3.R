require(ggplot2)
require(data.table)

scc <- readRDS("summarySCC_PM25.rds")
scc <- subset(scc, fips == "24510")

agg <- aggregate(Emissions ~ year + type, scc, sum)

png(filename = "plot3.png", height = 600, width = 800)

p <- qplot(year, Emissions, data = agg) 
p <- p + aes(color = type) 
p <- p + geom_smooth()

dev.off()

