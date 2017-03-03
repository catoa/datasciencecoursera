scc <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

coalSCC <- codes[grepl("Combustion", codes$SCC.Level.One) | grepl("Coal", codes$SCC.Level.Four),]

