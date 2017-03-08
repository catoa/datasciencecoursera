require(data.table, quietly = T)
require(ggplot2, quietly = T)

scc <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

codes.vehicle <- codes[grepl("Vehicle", codes$SCC.Level.Two), 1]

scc <- subset(scc, SCC %in% codes.vehicle & fips == "24510")

agg <- aggregate(Emissions ~ year, scc, sum)

png(filename = "plot5.png", width=840, height=480)

p <- ggplot(data = agg, aes(factor(year), Emissions))
p <- p + geom_bar(stat="identity") 
p <- p + xlab("Year") 
p <- p + ylab("Total Emissions")
p <- p + ggtitle("Total Emissions for Motor Vehicles in Baltimore (1999 - 2008)")

print(p)

dev.off()

