require(ggplot2)

scc <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

codes.coal <- codes[grepl("Combustion", codes$SCC.Level.One) | 
                        grepl("Coal", codes$SCC.Level.Four), 1]

scc <- subset(scc, SCC %in% codes.coal)

agg <- aggregate(Emissions ~ year, scc, sum)

png(filename = "plot4.png", height = 480, width = 480)

p <- qplot(year, Emissions, data = agg) 
p <- p + geom_smooth()
p <- p + xlab("Year")
p <- p + ggtitle("Total Emissions for Coal Combustion (1999-2008)")
p <- p + ylab("Emissions from Coal Combustion")
print(p)

dev.off()

