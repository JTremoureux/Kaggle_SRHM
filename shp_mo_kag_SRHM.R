rm(list = ls())

# Packages
library(sp)
library(dplyr)

# Data
mo_shp <- readOGR(dsn = "shp_mo", layer = "mo", stringsAsFactors = FALSE)
NAME_to_subarea <- read.csv(file = "NAME_to_subarea.csv", stringsAsFactors = FALSE)

# Join by sub_area
shp <- merge(mo_shp, NAME_to_subarea)

# Save a SpatialPolygonsDataFrame
saveRDS(shp, file = "shp.rds")

# Save an ESRI Shapefile

# I cant find how to save the file with the good russian encoding..
# .. so I prefer to drop the column
shp@data$NAME <- NULL
shp@data$NAME_AO <- NULL
shp@data$ABBREV_AO <- NULL
shp@data$TYPE_MO <- NULL

writeOGR(obj = shp, dsn = "shp_mo_kag_SRHM", layer = "mo_kag_SRHM", driver = "ESRI Shapefile", overwrite_layer = TRUE)

