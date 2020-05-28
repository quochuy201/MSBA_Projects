install.packages("randomForest")
library(randomForest)

install.packages("RODBC")
library(RODBC)

install.packages("tidyverse")
library(tidyverse)

####
# model with clustered data without crime
#===================================
conn <- odbcConnect("oitap22")
dfmn_wo <- sqlQuery(conn,"select * from [19su5510_tolenti4].[dbo].[FinalDataClusterWithoutCrime]") 
apply(dfmn_wo,2,range)

fullds <- dfmn_wo %>% select(-PersonalCrime, -DrugCrime, -OtherCrime, -Homicide, -PropertyCrime)  %>%
  mutate(cluster = as.numeric(substr(`Cluster`,8,9))) %>% 
  select(-`Cluster`)

fulldsCluster2 <- fullds %>% filter(cluster ==2)

#maxVals <- apply(fulldsCluster2, 2,max) 
#minVals <- apply(fulldsCluster2, 2,min) 

#dfmnNCluster2 <- as.data.frame(scale(fulldsCluster2, center = minVals, scale = (maxVals-minVals)))

#fullCluster2 <- fullds %>% filter(cluster ==2)

#dfmnNCluster2['Condition'] = fullCluster2['Condition']
#dfmnNCluster2['Quality'] = fullCluster2['Quality']
#dfmnNCluster2['SaleDate'] = fullCluster2['SaleDate']

# Partition the dataset for training and testing
set.seed(1234) #A seed can be any number you like

# Cluster 2
rs2 <- sample(nrow(fulldsCluster2), .8*nrow(fulldsCluster2))

Training2 <-fulldsCluster2[rs2,]
Testing2 <- fulldsCluster2[-rs2,]

attach(Training2)

colnames(Training2)

Training2[is.na(Training2)] <- 0
Testing2[is.na(Testing2)] <- 0

dim(Training2)
dim(Testing2)

# Build a random forest model with cluster 2
rfm2 <- randomForest(SalePrice ~Buildings+LandNetSquareFeet+SquareFeet+Condition+Quality+PhysicalAge+YearBuilt+YearRemodeled+TaxableValueCurrentYear+TaxableValuePriorYear, data = Training2)
print(rfm2)

# Evaluate random forest model with cluster 2
mse2 <- sum((rfm2$predicted - Training2$SalePrice)^2)/nrow(Training2)
mse2
sqrt(mse2)

mae2 <- sum(abs((rfm2$predicted - Training2$SalePrice)))/nrow(Training2)
mae2 #for comparison between models

# Evaluate random forest model with cluster 2 (Testing)
p2 <- predict(rfm2, Testing2[,-12])
mseTest2 <- sum((p2 - Testing2$SalePrice)^2)/nrow(Testing2)
mseTest2
sqrt(mseTest2)

maeTest2 <- sum(abs((p2 - Testing2$SalePrice)))/nrow(Testing2)
maeTest2 #for comparison between models

# Variable importance - Information Gain

varImpPlot(rfm2)
importance(rfm2)

odbcClose(conn)
