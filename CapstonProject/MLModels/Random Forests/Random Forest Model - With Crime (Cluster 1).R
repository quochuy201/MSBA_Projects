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

fulldsCluster1 <- fullds %>% filter(cluster ==1)

# maxVals <- apply(fulldsCluster1, 2,max) 
# minVals <- apply(fulldsCluster1, 2,min) 

# dfmnNCluster1 <- as.data.frame(scale(fulldsCluster1, center = minVals, scale = (maxVals-minVals)))

# fullCluster1 <- fullds %>% filter(cluster ==1)

# dfmnNCluster1['Condition'] = fullCluster1['Condition']
# dfmnNCluster1['Quality'] = fullCluster1['Quality']
# dfmnNCluster1['SaleDate'] = fullCluster1['SaleDate']

# Partition the dataset for training and testing
set.seed(1234) #A seed can be any number you like

# Cluster 1
rs1 <- sample(nrow(fulldsCluster1), .8*nrow(fulldsCluster1))

Training1 <-fulldsCluster1[rs1,]
Testing1 <- fulldsCluster1[-rs1,]

attach(Training1)

colnames(Training1)

Training1[is.na(Training1)] <- 0
Testing1[is.na(Testing1)] <- 0

dim(Training1)
dim(Testing1)

# Build a random forest model with cluster 1
rfm1 <- randomForest(SalePrice ~Buildings+LandNetSquareFeet+SquareFeet+Condition+Quality+PhysicalAge+YearBuilt+YearRemodeled+TaxableValueCurrentYear+TaxableValuePriorYear+DrugCrime+Homicide+PropertyCrime+PersonalCrime+OtherCrime, data = Training1)
print(rfm1)

# Evaluate random forest model with cluster 1
mse1 <- sum((rfm1$predicted - Training1$SalePrice)^2)/nrow(Training1)
mse1
sqrt(mse1) #for comparison betwwen models (RMSE)

mae1 <- sum(abs((rfm1$predicted - Training1$SalePrice)))/nrow(Training1)
mae1 #for comparison between models

# Evaluate random forest model with cluster 1 (Testing)
p1 <- predict(rfm1, Testing1[,-17])
mseTest1 <- sum((p1 - Testing1$SalePrice)^2)/nrow(Testing1)
mseTest1
sqrt(mseTest1) #for comparison between models

maeTest1 <- sum(abs((p1 - Testing1$SalePrice)))/nrow(Testing1)
maeTest1 #for comparison between models

# Variable importance - Information Gain

varImpPlot(rfm1)
importance(rfm1)

odbcClose(conn)
