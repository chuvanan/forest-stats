


library(reshape2)

setwd("~/Documents/forest-stats/data/")

## -----------------------------------------------------------------------------
## Import data

forest.land <- read.csv("API_AG.LND.FRST.ZS_DS2_en_csv_v2.csv",
                        skip = 3,
                        stringsAsFactors = FALSE)

names(forest.land) <- gsub("\\.", "", names(forest.land))

## remove empty columns

forest.land <- Filter(function(x) !all(is.na(x)), forest.land)

## rounding

forest.land[] <- lapply(forest.land,
                        function(x) x <- if (is.double(x)) round(x, 2) else x)

## reshaping into long format for easier plotting

forest.land <- melt(forest.land,
                    id.vars = c("CountryName", "CountryCode", "IndicatorName",
                                "IndicatorCode"),
                    variable.name = "Year",
                    value.name = "Perct")

forest.land$Year <- gsub("X", "", forest.land$Year)
forest.land$Year <- as.integer(forest.land$Year)

## -----------------------------------------------------------------------------
## Analysing forest coverage
