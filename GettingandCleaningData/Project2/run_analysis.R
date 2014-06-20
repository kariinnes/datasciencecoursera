#Reading Data In
setwd("./UCIHARDataset")

#Read Data
trainData_x <- read.table("./train/X_train.txt")  #test results
trainData_y <- read.table("./train/Y_train.txt")  #activity ID
trainData_subject <- read.table("./train/subject_train.txt")  #person ID

testData_x <- read.table("./test/X_test.txt")   #test results
testData_y <- read.table("./test/Y_test.txt")   #activity ID
testData_subject <- read.table("./test/subject_test.txt")  #person ID

activityLabels <- read.table("activity_labels.txt")   #descriptive activity labels
columnNames <-  read.table("features.txt")   #descriptive measurement labels

#Give column names meaningful labels - loop through column names to set better names

replace <- function(pattern, replacement, x, ...) {
        result <- x
        for (i in 1:length(pattern)) {
                result <- gsub(pattern[i], replacement[i], result, ...)
        }
        result
}

columnNames$V2 <- replace(c("-","t","f","\\(","\\)"), c("_","","","",""), columnNames$V2)

#Add Column names to test and train data measurement data files per features.txt
colnames(testData_x) <- colnames(trainData_x) <- columnNames$V2

#Add Column names to Subject ID and Activity ID files
colnames(testData_subject) <- colnames(trainData_subject) <- "subject_ID" 

colnames(testData_y) <- colnames(trainData_y) <- "activity_code"

colnames(activityLabels) <- c("activity_code", "activity")

#Combine x, y and subject data files so data includes subject ID (column1) and activity ID (column 2) 
trainData <- cbind(trainData_subject, trainData_y, trainData_x) 

testData <- cbind(testData_subject, testData_y, testData_x)

#Combine test data and train data files
mergeData <- rbind(trainData, testData)

#Subset data for only mean and std measurements 
#See CodeBook for fields determined to include mean and std (add 2 to columns listed since 
#we have added Subject ID and Activity ID to beginning of the file)
subsetData <- mergeData[ ,c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)] 

#Add another column with descriptive activty

library(plyr)
subsetData <- join(subsetData, activityLabels, by = "activity_code")

#Calculate mean and standard deviation of each variable for each activity and each subject
library(reshape2)
subjectActivityMean <- ddply(subsetData,.(subject_ID, activity), numcolwise(mean))

#Remove activity code since we have a more meaningful activity label
subjectActivityMean$activity_code <- NULL

#Write resulting data to a .txt file
write.table(subjectActivityMean, file = "tidyDataSet.txt")