####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Importing libraries
library(RCurl) # for downloading the iris CSV file
library(randomForest)
library(caret)

# Importing the Iris data set
iris <- read.csv(text = getURL("https://github.com/dataprofessor/code/blob/master/shiny/004-iris-predictor/training.csv") )

# Performs stratified random split of the data set
TrainingIndex <- initial_split(iris, prop=0.8, strata= iris$Species)
TrainingSet <- iris[TrainingIndex,] # Training Set
TestingSet <- iris[-TrainingIndex,] # Test Set

write.csv(TrainingSet, "training.csv")
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Building Random forest model

model <- randomForest(Species ~ ., data = TrainSet, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
saveRDS(model, "model.rds")

