library(raster)
library(sf)
library(tidyverse)

# read mfe
qp_spain <-
  st_read("/Users/ajpelu/Google Drive/_phd/_geoinfo/dist_PIberica/mapa_forestal/MfeMax_ForArb15.shp") %>%
  mutate(sp="qp") %>%
  st_transform(4326) %>%
  select(sp)



# hillshade from
# https://www.eea.europa.eu/data-and-maps/data/digital-elevation-model-of-europe
# h <- raster("/Users/ajpelu/Google Drive/_phd/_geoinfo/aux/hillshade1x1/hillshade1x1.tif")
# h <- projectRaster(h, crs = "+init=EPSG:25830")
# # crop hillshade
# bb <- as(extent(-70000, 1100000, 3800000, 5000000), 'SpatialPolygons')
# crs(b) <- crs(h)
# hspain <- crop(h, b)
# plot(hspain)
# writeRaster(hspain,
#             file = "/Users/ajpelu/Google Drive/_phd/_geoinfo/aux/hillshade1x1/spain.tif")


h <- raster("/Users/ajpelu/Google Drive/_phd/_geoinfo/aux/hillshade1x1/spain.tif") %>%
  raster::as.data.frame(xy=TRUE) %>%
  na.omit()

ggplot() +
  geom_raster(data = h, mapping = aes(x = x, y = y, fill=spain), alpha = .90) +
  scale_fill_gradientn(colours = grey.colors(100), guide = "none") +
  theme_bw() + coord_sf()



  geom_raster(data = h, aes(x = x, y = y, fill = spain))


p <- ggplot(data = rast_df) +
  geom_sf(data = poly, fill = NA, colour = "blue", size = 0.25) +
  geom_tile(data = rast_df %>% filter(is.na(value)), mapping = aes(x = x, y = y), size = 0.25, fill = NA, color = alpha("gray", 0.25)) +
  geom_tile(data = rast_df %>% filter(!is.na(value)), mapping = aes(x = x, y = y), size = 0.25, fill = NA, color = alpha("red", 0.5)) +
  theme_map()


+
  coord_sf(crs = st_crs(4326))
+
  # geom_sf(qp_spain) +
 #  scale_fill_gradient(low = "brown", high = "black", guide="none")


)
  scale_alpha(range =  c(0.1, 0.9), guide = "none")

  geom_raster(data = DEM_hill_df, aes(x = x, y = y, alpha = Hillshade_DEM1)) +
  scale_alpha(range =  c(0.15, 0.65), guide = "none")



geom_raster(data = DSM_HARV_df ,
            aes(x = x, y = y,
                fill = HARV_dsmCrop,
                alpha=0.8)
)
