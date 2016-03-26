# One of the most exciting areas in all of data science right now is wearable computing. 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms 
# to attract new users. 
# 
# The data linked to from the course website represent data collected from the accelerometers 
# from the Samsung Galaxy S smartphone. A full description is available at the site where the 
# data was obtained:
#      
#      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
#      
#      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following:
# 
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation for each measurement.
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive variable names.
# (5) From the data set in step 4, creates a second, independent tidy data set with the 
#     average of each variable for each activity and each subject.
    
# Set working directory to location of UCI HAR Dataset

setwd("~/Dropbox/Coursera/Getting and Cleaning Data/Course Project/UCI HAR Dataset")

# clean up workspace (RStudio)

rm(list = ls())

# read files 
     # read in files "./UCI HAR Dataset/

     activityLabels <- read.table("./activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)
     features <- read.table("./features.txt", header = FALSE, stringsAsFactors = FALSE)
     
          # read in files "./UCI HAR Dataset/test/
     
          subjectTest <- read.table("./test/subject_test.txt", header = FALSE)
          xTest <- read.table("./test/X_test.txt", header = FALSE)
          yTest <- read.table("./test/y_test.txt", header = FALSE)
          
          # read in files "./UCI HAR Dataset/train/
          
          subjectTrain <- read.table("./train/subject_train.txt", header = FALSE)
          xTrain <- read.table("./train/X_train.txt", header = FALSE)
          yTrain <- read.table("./train/y_train.txt", header = FALSE)
          
# assign column names
          
     colnames(activityLabels) <- c("activityId", "activity")
     colnames(features)       <- c("featureId", "feature")
     colnames(subjectTest)    <- c("volunteerId")
     colnames(xTest)          <- features[, 2]
     colnames(yTest)          <- c("activityId")
     colnames(subjectTrain)   <- c("volunteerId")
     colnames(xTrain)         <- features[, 2]
     colnames(yTrain)         <- c("activityId")
     
# aggregate test data (columns)

testData <- cbind(subjectTest, yTest, xTest)

# aggregate train data (columns)

trainData <- cbind(subjectTrain, yTrain, xTrain)

# (1) Merges the training and the test sets to create one data set.

allData <- rbind(testData, trainData)
          
# (2) Extracts only the measurements on the mean and standard deviation for each measurement.
# NOTE: assumed "meanFreq()" measurements (13) were not to be included...only "mean()-"
          
featureData <- features[grepl("(mean[^F])|(std)", features$feature), ]
meanAndstandardData <- cbind(allData[,1:2], allData[, featureData[, 2]])

# (3) Uses descriptive activity names to name the activities in the data set

for (i in 1:nrow(activityLabels)) {
     meanAndstandardData$activityId[meanAndstandardData$activityId == i] <- activityLabels[i, 2]  
}

# (4) Appropriately labels the data set with descriptive variable names.
# Changes to clean up varialbe (column) names:
#
#      t = time            Mag  = Magnitude         -mean = Mean     Acc      = Accel
#      f = Frequency       -std = StdDev            remove "( )"     BodyBody = Body     

colNames <- colnames(meanAndstandardData)

for (i in 1:length(colNames)) {
     colNames[i] <- gsub("^t", "Time", colNames[i])
     colNames[i] <- gsub("^f", "Freq", colNames[i])
     colNames[i] <- gsub("[Mm]ag", "Magnitude", colNames[i])
     colNames[i] <- gsub("-[Ss]td", "StdDev", colNames[i])
     colNames[i] <- gsub("-[Mm]ean", "Mean", colNames[i])
     colNames[i] <- gsub("\\()", "", colNames[i])
     colNames[i] <- gsub("[Aa]cc", "Accel", colNames[i])
     colNames[i] <- gsub("[Bb]ody[Bb]ody", "Body", colNames[i])
}

# Replace columnames in meanAndstandardData with new columnames in colNames

colnames(meanAndstandardData) <- colNames

# (5) From the data set in step 4, creates a second, independent tidy data set with the 
#     average of each variable for each activity and each subject.
# install reshape2 package for melt( ) and dcast( )

library(reshape2)

# If you only supply one of id.vars and measure.vars, melt will assume the remainder 
# of the variables in the data set belong to the other. Specify id.vars and melt( )
# will assume remainder are measure.vars
# colNmaes[2] = "activityId"
# colNames[1] = "volunteerId"

meltData <- melt(meanAndstandardData, id = c("activityId", "volunteerId"))
meanData <- dcast(meltData, activityId + volunteerId ~ variable, mean)

# Write/export tidy data set

write.table(meanData, "./tidyData.txt", sep = "\t", row.names = FALSE, col.names = TRUE)




