install.packages("randomForest")
library(randomForest)

install.packages("RODBC")
library(RODBC)

install.packages("tidyverse")
library(tidyverse)

####
# model with clustered data with crime
#===================================
conn <- odbcConnect("oitap22")
dfmn <- sqlQuery(conn,"select * from [19su5510_tolenti4].[dbo].[FinalDataClusterWithCrime]") 
apply(dfmn,2,range)

fullds <- dfmn %>% mutate(cluster = as.numeric(substr(`Cluster`,8,9))) %>% 
  select(-`Cluster`)

fulldsCluster3 <- fullds %>% filter(cluster ==3)

#maxVals <- apply(fulldsCluster3, 2,max) 
#minVals <- apply(fulldsCluster3, 2,min) 

#dfmnNCluster3 <- as.data.frame(scale(fulldsCluster3, center = minVals, scale = (maxVals-minVals)))

#fullCluster3 <- fullds %>% filter(cluster ==3)

#dfmnNCluster3['Condition'] = fullCluster3['Condition']
#dfmnNCluster3['Quality'] = fullCluster3['Quality']
#dfmnNCluster3['SaleDate'] = fullCluster3['SaleDate']

# Partition the dataset for training and testing
set.seed(1234) #A seed can be any number you like

# Cluster 3
rs3 <- sample(nrow(fulldsCluster3), .8*nrow(fulldsCluster3))
Training3 <-fulldsCluster3[rs3,]
Testing3 <- fulldsCluster3[-rs3,]

attach(Training3)

colnames(Training3)

Training3[is.na(Training3)] <- 0
Testing3[is.na(Testing3)] <- 0

dim(Training3)
dim(Testing3)

# Build a random forest model with cluster 3
rfm3 <- randomForest(SalePrice ~Buildings+LandNetSquareFeet+SquareFeet+Condition+Quality+PhysicalAge+YearBuilt+YearRemodeled+TaxableValueCurrentYear+TaxableValuePriorYear+DrugCrime+Homicide+PropertyCrime+PersonalCrime+OtherCrime, data = Training3)
print(rfm3)

# Evaluate random forest model with cluster 3
mse3 <- sum((rfm3$predicted - Training3$SalePrice)^2)/nrow(Training3)
mse3
sqrt(mse3) #for comparison betwwen models (RMSE)

mae3 <- sum(abs((rfm3$predicted - Training3$SalePrice)))/nrow(Training3)
mae3 #for comparison between models

# Evaluate random forest model with cluster 3 (Testing)
p3 <- predict(rfm3, Testing3[,-17])
mseTest3 <- sum((p3 - Testing3$SalePrice)^2)/nrow(Testing3)
mseTest3
sqrt(mseTest3)

maeTest3 <- sum(abs((p3 - Testing3$SalePrice)))/nrow(Testing3)
maeTest3 #for comparison between models

#Variable importance - Information Gain

varImpPlot(rfm3)
importance(rfm3)

odbcClose(conn)
