Codebook

========

##The database is downloaded from:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 

##Input Data used are:

- 'train/subject_train.txt' and 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/X_train.txt': Training set.

- 'test/X_test.txt': Test set.

- 'train/y_train.txt': Training labels.

- 'test/y_test.txt': Test labels.


- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.


##The names of the local variable used to read the data

- SubjectTrain  "subject_train.txt" 

- SubjectTest  "subject_test.txt" 

- TrainX  "X_train.txt" 

- TestX  "X_test.txt" 

- TrainY  "Y_train.txt" 

- TestY  "Y_test.txt" 

- Features  "features.txt" 

- ActivityNames    "activity_labels.txt" 

## Step 1. Merging the training TrainX with the test sets TestX to create one data set xData.

xData <- rbind(TrainX,TestX)

##Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

-We are using Features$V1 to create a new table that can be used to select the mean and standard deviation for each measurement in xData.

columnCodes <- paste("V",Features$V1,sep="")
Feature_Selecter <- cbind(Features, columnCodes)
Feature_Selecter <- Feature_Selecter[grepl("mean\\(\\)|std\\(\\)", V2)] 
mean_N_std_data <- xData[, Feature_Selecter$columnCodes, with = FALSE]

- Now I have a new dataset with only the mean and std for each measurement

##Step 3. Using descriptive activity names to name the activities in the data set

ActivityID <- rbind(TrainY,TestY)

-match the activity id's with the activity names

Approp_labels <-ActivityNames[match(ActivityID$V1,ActivityNames$V1),]

- Overwriting the with the new descriptive activity names

ActivityID$V1 <- Approp_labels$V2

##Step 4. Appropriately labeling the data set with descriptive variable names.

-Renaming Columns in Subject and Activity Data 
setnames(SubjectData, "V1", "subject")
setnames(ActivityID, "V1", "activity")

- here I am Basicly reusing the same descriptive variable names used in "features.txt" 
setnames(mean_N_std_data, old =  Feature_Selecter$columnCodes, new = Feature_Selecter$V2)

##Step 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

Dataset <- cbind(SubjectData,ActivityID)
Dataset <- cbind(Dataset,mean_N_std_data)
tidyData <- aggregate(. ~subject + activity,Dataset,mean)
tidyData <- tidyData [order(tidyData$subject,tidyData$activity),]

-Writing out the final tidy Data
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
