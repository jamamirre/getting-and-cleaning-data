#Loading libraries and getting things ready
library("data.table")
library("plyr")
library(knitr)

if(!file.exists("Project")){
  dir.create("Project")
}

wd <- getwd()

setwd(".\\Project")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")

unzip ("dataset.zip")

fdir <- file.path(getwd(), "UCI HAR Dataset")

#Reading Data
SubjectTrain <- fread(file.path(fdir, "train", "subject_train.txt"))
SubjectTest <- fread(file.path(fdir,  "test", "subject_test.txt"))
TrainX <- fread(file.path(fdir,"train","X_train.txt"))
TestX <- fread(file.path(fdir,"test","X_test.txt"))
TrainY <- fread(file.path(fdir,"train", "Y_train.txt"))
TestY <- fread(file.path(fdir,"test", "Y_test.txt"))
Features <- fread(file.path(fdir,"features.txt"))
ActivityNames<- fread(file.path(fdir,"activity_labels.txt"))

#1. Merges the training and the test sets to create one data set.
xData <- rbind(TrainX,TestX)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
columnCodes <- paste("V",Features$V1,sep="")
Feature_Selecter <- cbind(Features, columnCodes)
Feature_Selecter <- Feature_Selecter[grepl("mean\\(\\)|std\\(\\)", V2)] 
mean_N_std_data <- xData[, Feature_Selecter$columnCodes, with = FALSE]

#3. Using descriptive activity names to name the activities in the data set
ActivityID <- rbind(TrainY,TestY)
Approp_labels <-ActivityNames[match(ActivityID$V1,ActivityNames$V1),]
ActivityID$V1 <- Approp_labels$V2

#4. Appropriately labeling the data set with descriptive variable names. 
SubjectData <- rbind(SubjectTrain,SubjectTest)
setnames(SubjectData, "V1", "subject")
setnames(ActivityID, "V1", "activity")
# here I am Basicly reusing the same feature labels in "features.txt" 
setnames(mean_N_std_data, old =  Feature_Selecter$columnCodes, new = Feature_Selecter$V2)



#5. And finally creating a second, independent tidy data set with the average of each variable for each activity and each subject.
Dataset <- cbind(SubjectData,ActivityID)
Dataset <- cbind(Dataset,mean_N_std_data)
tidyData <- aggregate(. ~subject + activity,Dataset,mean)
tidyData <- tidyData [order(tidyData$subject,tidyData$activity),]
write.table(tidyData, file = "tidyData.txt", row.names = FALSE) 




