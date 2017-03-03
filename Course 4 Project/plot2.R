require(data.table)

data <- readRDS("summarySCC_PM25.rds")

MD.data <- subset(data, fips == "24510")

MD.agg <- aggregate(Emissions ~ year, MD.data, sum)


png(filename = "plot2.png")

barplot(height = MD.agg$Emissions,
        names.arg = MD.agg$year,
        col = "cadetblue",
        main = "Yearly Total Emissions for Maryland",
        xlab = "Years",
        ylab = "Total Emissions for Maryland per Year")

dev.off()

