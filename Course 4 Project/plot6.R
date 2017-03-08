require(data.table, quietly = T)
require(ggplot2, quietly = T)

scc <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

codes.vehicle <- codes[grepl("Vehicle", codes$SCC.Level.Two), 1]

scc.CA <- subset(scc, SCC %in% codes.vehicle & fips == "24510")
scc.MD <- subset(scc, SCC %in% codes.vehicle & fips == "06037")

agg.scc.CA <- aggregate(Emissions ~ year + fips, scc.CA, sum)
agg.scc.MD <- aggregate(Emissions ~ year + fips, scc.MD, sum)

agg.data <- rbind(agg.scc.CA, agg.scc.MD)

agg.data$fips <- as.factor(agg.data$fips)
levels(agg.data$fips) <- c("Los Angeles", "Baltimore")

png(filename = "plot6.png", height = 600, width = 600)

p <- qplot(year, Emissions, data = agg.data) 
p <- p + aes(color = fips) 
p <- p + geom_smooth()
p <- p + xlab("Year")
p <- p + ylab("Annual Emissions for Baltimore and Los Angeles")
print(p)

dev.off()
