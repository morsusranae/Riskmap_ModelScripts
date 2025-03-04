library(dplyr)
library(ggplot2)
library(leaflet)
library(sf)
options("sp_evolution_status" = 2)
library(sp) 
library(terra)
library(randomForest)

setwd("Z:/Riskmap/ForClayton_2025")
setwd("/bsuhome/path/to/directory/PredictiveSDMs_2024/")

#sdm_data <- read.csv("FINALFINAL_SentCorrections.csv")

#######------full model to run predictions-----###### 
#model object from previous script 
final_preds <- get(load("/bsuhome/louisjochems/PredictiveSDMs_2024/CaretM_AllPredictors.RData"))

#low water level year 
stack_pred20 <- rast("Comp2020.tif")
#high water level year 
stack_pred23 <- rast("Comp2023.tif")
#NOTE: I composited and masked these raster stacks by their 
#respective annual water level extents in GIS 


## may need to subset raster to exclude certain bands, this is how you would do it
#stack_pred <-stack_pred23[[c(1:8)]]

#need to rename to make sure band names match those in model object 
names(stack_pred20) <- c('medianVV','medianVH','medianVH_VV_ratio',
                         'medianNDVI','medianNDWI','Monthly_HD', 
                         'Dist_NearEFB','Dist_NearBL','MeanFetch') 

names(stack_pred23) <- c('medianVV','medianVH','medianVH_VV_ratio',
                         'medianNDVI','medianNDWI','Monthly_HD', 
                         'Dist_NearEFB','Dist_NearBL','MeanFetch') 
#REMEMBER ORDER OF COMPLETE COMPOSITE

######----how to run model predictions on complete raster-----###### 
#p1_2020 <- terra::predict(stack_pred20, final_preds, se.fit = TRUE, 
#                          filename="Preds2020_new.tif",
#                          overwrite=TRUE) #inf.rm = TRUE na.rm = TRU
p1_2023 <- terra::predict(stack_pred23, final_preds, se.fit = TRUE, 
                          filename="Preds2023_new.tif", 
                          overwrite=TRUE, na.rm = TRUE)

#check real quick if predictors look good 
#plot(p1_2023)