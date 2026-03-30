library(dplyr)
library(ggplot2)
library(leaflet)
library(sf)
options("sp_evolution_status" = 2)
library(sp) 
library(terra)
library(randomForest)
library(caret)

setwd("/path/to/directory/")

#######------load in dispersal model and raster for predictions-----###### 
#model object from previous script 
disp_mod <- get(load("/path/to/CaretM_Dispersal.RData"))

#high water level year 
disp_stack <- rast("DispersalRaster.tif")

######------run predictions-----#######
#first make sure raster bands match names of predictors in model object
names(disp_stack) <- c('Dist_NearBL','Dist_NearEFB') 

disp_preds <- terra::predict(disp_stack, disp_mod, se.fit = TRUE, 
                          filename="EFB_Dispersal_Predictions.tif", 
                          overwrite=TRUE, na.rm = TRUE)

#quick plot of predictions on raster
#plot(disp_preds)