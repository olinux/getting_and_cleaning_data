
library(dplyr)

features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features <- as.character(features$V2)
#features <- sapply(features, function(x){gsub("\\(\\)", "", x)})

#Read the train data and extract means and standard deviations
trainData <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
colnames(trainData) <- as.character(features)
trainData <- trainData[, grep(".*((mean)|(std))\\(\\).*", colnames(trainData))]
colnames(trainData) <- sapply(colnames(trainData), function(x){gsub("\\(\\)", "", x)})
colnames(trainData) <- sapply(colnames(trainData), function(x){gsub("-", "", x)})

#Read the test data and extract means and standard deviations
testData <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
colnames(testData) <- as.character(features)
testData <- testData[, grep(".*((mean)|(std))\\(\\).*", colnames(testData))]
colnames(testData) <- sapply(colnames(testData), function(x){gsub("\\(\\)", "", x)})
colnames(testData) <- sapply(colnames(testData), function(x){gsub("-", "", x)})

#Load the label identifiers for train data and add it
trainLabels <- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
extendedTrainData <- cbind(trainData, trainLabels$V1)
colnames(extendedTrainData)[colnames(extendedTrainData)=="trainLabels$V1"] <- "label"

#Load the label identifiers for test data and add it
testLabels <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
extendedTestData <- cbind(testData, testLabels$V1)
colnames(extendedTestData)[colnames(extendedTestData)=="testLabels$V1"] <- "label"

#Load the subject identifiers for train data and add it
trainSubjects <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
extendedTrainData <- cbind(extendedTrainData, trainSubjects$V1)
colnames(extendedTrainData)[colnames(extendedTrainData)=="trainSubjects$V1"] <- "subject"

#Load the subject identifiers for train data and add it
testSubjects <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
extendedTestData <- cbind(extendedTestData, testSubjects$V1)
colnames(extendedTestData)[colnames(extendedTestData)=="testSubjects$V1"] <- "subject"

#Combine the two datasets
allData <- rbind(extendedTestData, extendedTrainData)

# load the activity labels and merge them with the dataset
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(activity_labels)<-c("labelid", "activity")
allData <- merge(allData, activity_labels, by.x="label", by.y="labelid")


#Extract another data set containing the average value of all variables grouped by the subject and the activity.
averageData <- allData %>% group_by(subject, activity) %>% summarise_each(funs(mean))
colnames(averageData) <- sapply(colnames(averageData), function(x){if(x!="label" & x!="subject" & x!="activity"){paste0(x, "Avg")}else{x}})
write.table(averageData, row.name=FALSE, file="result.txt")

