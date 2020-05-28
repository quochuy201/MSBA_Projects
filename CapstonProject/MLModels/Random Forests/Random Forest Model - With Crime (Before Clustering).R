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

# Partition the dataset for training and testing
set.seed(1234) #A seed can be any number you like

# Before Clustering
rs <- sample(nrow(fullds), .8*nrow(fullds))

Training <-fullds[rs,]
Testing <- fullds[-rs,]

attach(Training)

colnames(Training)

Training[is.na(Training)] <- 0
Testing[is.na(Testing)] <- 0

dim(Training)
dim(Testing)

# Build a random forest model before clustering
rfm <- randomForest(SalePrice ~Buildings+LandNetSquareFeet+SquareFeet+Condition+Quality+PhysicalAge+YearBuilt+YearRemodeled+TaxableValueCurrentYear+TaxableValuePriorYear+DrugCrime+Homicide+PropertyCrime+PersonalCrime+OtherCrime, data = Training)
print(rfm)

# Evaluate random forest model before clustering
mse <- sum((rfm$predicted - Training$SalePrice)^2)/nrow(Training)
mse
sqrt(mse) #for comparison betwwen models (RMSE)

mae <- sum(abs((rfm$predicted - Training$SalePrice)))/nrow(Training)
mae #for comparison between models

# Evaluate random forest model before clustering (Testing)
p <- predict(rfm, Testing[,-17])
mseTest <- sum((p - Testing$SalePrice)^2)/nrow(Testing)
mseTest
sqrt(mseTest) #for comparison between models

maeTest <- sum(abs((p - Testing$SalePrice)))/nrow(Testing)
maeTest #for comparison between models

# Variable importance - Information Gain

varImpPlot(rfm)
importance(rfm)

odbcClose(conn)
