library(rgdal)
library(maptools)
library(rgeos)

#projection in source file is ESPG:28992, WGS84projection is EPSG:4326
projRD <- CRS("+init=epsg:28992")
projWGS84 <- CRS("+init=epsg:4326")


toGeoJSON <- function(x, name="gem", plot=FALSE){
  
  gem <- readShapeSpatial(x)
  proj4string(gem) <- projRD
  data <- gem@data

  # hack: it is csv data, but browser won't load ".csv" data, unless it is named ".json".
  write.csv(data, paste("json/",name,"_data.json",sep=""), row.names=FALSE)
  
  gem_s <- gSimplify(gem, tol=1e2, topologyPreserve=TRUE)

  if (plot){
    plot(gem, border="grey")
    plot(gem_s, add=TRUE, border="black")
  }
  
  gem <- SpatialPolygonsDataFrame(gem_s, data[1:2])
  names(gem) <- c("id", "name")
  writeOGR(gem, paste("json/",name,".json",sep=""), name,driver="GeoJSON", overwrite_layer=TRUE)
  invisible(gem)
}

toGeoJSON(x="data/gem_2010_gn2.shp", name="gemeenten")
# toGeoJSON(x="data/wijk_2010_gn2.shp", name="wijken")
# toGeoJSON(x="data/brt_2010_gn2.shp", name="buurten")