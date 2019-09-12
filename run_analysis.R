#======================================
# Developed by Pedro Silva 
# SEP 12 2019
#======================================


  library(dplyr)
  library(data.table)
  
  
#=========================================
#   BLOCK 1 - preparing metadata
#=========================================
  
    #read activity labels
      labels <- read.csv(".\\UCI HAR Dataset\\activity_labels.TXT", col.names = c("activityId","activityDesc"), sep=" ", header = FALSE)
    
    #prepare varibles names & identify variables and columns to read from data sets
      features <- read.csv(".\\UCI HAR Dataset\\features.TXT", 
                           sep = " ", 
                           header = FALSE, 
                           col.names = c("idx", "feature"), 
                           strip.white = TRUE)
      varIndex <- grep(".*\\-mean\\(\\)-.*|.*\\-std\\(\\)-.*", features$feature)
      varNames <- gsub("[^a-z0-9]","",tolower(features[varIndex, 2]))
  
      rm(features)  
#=========================================          
#   BLOCK 2 - uploading data sets 
#=========================================        
      
      
    #read and assemble train data set
    trainData <- fread(file=".\\UCI HAR Dataset\\train\\X_train.TXT",
                          col.names = varNames,
                          select = varIndex,
                          header = FALSE,
                          data.table = FALSE)
    trainSubjects <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.TXT" ,header=FALSE, col.names = "subject")
    trainActivities <- read.csv(".\\UCI HAR Dataset\\train\\y_train.TXT", col.names = "activityId", header = FALSE)
    trainActivities <- left_join(trainActivities, labels, by="activityId")

    trainData <- cbind("subject" = trainSubjects, "activity" = trainActivities$activityDesc, trainData)
    
  
    #read and assemble test data set
    testData <- fread(file=".\\UCI HAR Dataset\\test\\X_test.TXT",
                          col.names = varNames,
                          select = varIndex,
                          header = FALSE,
                          data.table = FALSE)
    
    testSubjects <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.TXT" ,header=FALSE, col.names = "subject")
    testActivities <- read.csv(".\\UCI HAR Dataset\\test\\y_test.TXT", col.names = "activityId", header = FALSE)
    testActivities <- left_join(testActivities, labels, by="activityId")
  
    testData <- cbind("subject" = testSubjects, "activity" = testActivities$activityDesc, testData)

    #cleanup
      rm(testSubjects, testActivities, trainSubjects, trainActivities, labels, varIndex, varNames)      
    
#=========================================        
# BLOCK 3 assembling the final datasets 
#=========================================    

    #merge test & train sets
      finalDataSet <- rbind(testData, trainData)
      finalDataSet <- arrange (finalDataSet, subject, activity)
    
    
    #mean aggregatation per subject and activity
      summaryDataSet <- aggregate(finalDataSet[-c(1,2)],by=list(subject = finalDataSet$subject, activity = finalDataSet$activity) , mean)
      summaryDataSet <- arrange(summaryDataSet, subject, activity)
    
    #cleanup
      rm(testData, trainData)
    
    # write to file
      write.table(summaryDataSet, file="summaryDataSet.txt", row.names = FALSE)
      summaryDataSet
  