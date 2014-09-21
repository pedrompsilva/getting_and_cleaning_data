

#include

library(data.table)
library(dplyr)


#common loads
colHeaders <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/features.txt")
activities <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("act_id", "activity")


# building train set
trainSubject <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/train/subject_train.txt")
trainX <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/train/Y_train.txt")

#add column names
names(trainSubject)<-"subject"
names(trainX) <- t(colHeaders[2])
names(trainY) <- "act_id"

#joining all train dsets 
trainDS <- cbind(trainSubject, trainY, trainX)

# handle test sets
testSubject <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/test/subject_test.txt")
testX <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./Coursera - Getting Data Project/final project/UCI HAR Dataset/test/Y_test.txt")

#add column names
names(testSubject)<-"subject"
names(testX) <- t(colHeaders[2])
names(testY) <- "act_id"

#joining all test dsets 
testDS <- cbind(testSubject, testY, testX)

#build final DSet
totalDS <- rbind(trainDS, testDS) 
totalDS <- left_join(totalDS,activities)
totalDS <- select(totalDS,subject, activity, matches("-mean[()]|-std[()]"))


#cleanup
rm(trainDS, testDS, activities)
rm(trainX, trainY, trainSubject)
rm(testX,  testY, testSubject, colHeaders)


# perform aggregation
group_subject_activity <- group_by(totalDS, subject, activity)
agg <- sapply(names(group_subject_activity)[3:68] ,function(x) substitute(mean(x), list(x=as.name(x))))
agg_subject_activity <- do.call(summarise, c(list(.data=group_subject_activity), agg))

#cleanup
rm(group_subject_activity, agg, totalDS)

agg_subject_activity

print("End of script")
