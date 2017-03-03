scc <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

codes.coal <- codes[grepl("Combustion", codes$SCC.Level.One) | 
                        grepl("Coal", codes$SCC.Level.Four), 1]

scc <- subset(scc, SCC %in% codes.coal)

agg <- aggregate(Emissions ~ year + type, scc, sum)

png(filename = "plot4.png", height = 600, width = 800)

p <- qplot(year, Emissions, data = agg) 
p <- p + aes(color = type) 
p <- p + geom_smooth()

dev.off()
