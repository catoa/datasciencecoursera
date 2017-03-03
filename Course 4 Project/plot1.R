# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

require(data.table, quietly = T)

summary.scc <- readRDS("summarySCC_PM25.rds")

agg.year <- aggregate(Emissions ~ year, summary.scc, sum)

names(agg.year) <- c("Year", "Total.Emissions")

png(filename = "plot1.png")
barplot(height= agg.year$Total.Emissions, 
        names.arg = c("1999", "2002", "2005", "2008"),
        xlab = "Years",
        ylab = "Total Emissions Per Year",
        col = "springgreen")

dev.off()

