  library(dplyr)
  library(data.table)
  #library(tidyselect)
  
  
  

  #read activity labels
    labels <- read.csv(".\\UCI HAR Dataset\\activity_labels.TXT", col.names = c("activityId","activityDesc"), sep=" ", header = FALSE)
  
  #prepare varibles names & identify variables and columns to read from data sets
    features <- read.csv(".\\UCI HAR Dataset\\features.TXT", 
                         sep = " ", 
                         header = FALSE, 
                         col.names = c("idx", "feature"), 
                         strip.white = TRUE)
    varIndex <- grep("mean|std", features$feature)
    varNames <- gsub("[^a-z0-9]","",tolower(features[varIndex, 2]))
    
    a <- cbind(varIndex, varNames)

  #read train data set
  trainSetData <- fread(file=".\\UCI HAR Dataset\\train\\X_train.TXT",
                        col.names = varNames,
                        select = varIndex,
                        header = FALSE,
                        data.table = FALSE)
  trainSubjects <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.TXT" ,header=FALSE, col.names = "subject")
  trainActivities <- read.csv(".\\UCI HAR Dataset\\train\\y_train.TXT", col.names = "activityId", header = FALSE)
  
  
  trainActivities <- left_join(trainActivities, labels)
  trainSetData <- cbind("subject" = trainSubjects, "activity" = trainActivities$activityDesc, trainSetData)
  
  
  
  #read test data set=====================================================================
  
  testSetData <- fread(file=".\\UCI HAR Dataset\\test\\X_test.TXT",
                        col.names = varNames,
                        select = varIndex,
                        header = FALSE,
                        data.table = FALSE)
  
  testSubjects <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.TXT" ,header=FALSE, col.names = "subject")
  testActivities <- read.csv(".\\UCI HAR Dataset\\test\\y_test.TXT", col.names = "activityId", header = FALSE)
  
  #assemble test data set
  testActivities <- left_join(testActivities, labels)
  testSetData <- cbind("subject" = testSubjects, "activity" = testActivities$activityDesc, testSetData)
  
  
  #merge test & train sets
  finalDataSet <- rbind(testSetData, trainSetData)
  finalDataSet <- arrange (dataSet, subject, activity)
  
  
  #mean aggregatation per subject and activity
  summaryDataSet <- aggregate(finalDataSet[3:81],by=list(subject = finalDataSet$subject, activity = finalDataSet$activity) , mean)
  summaryDataSet <- arrange(summaryDataSet, subject, activity)
  
  
  #clear memory
  rm(testSetData, 
     testSubjects, 
     testActivities,
     trainSetData, 
     trainSubjects, 
     trainActivities,
     dataSet, 
     varNames, 
     varIndex, 
     features, 
     labels)  
  
  