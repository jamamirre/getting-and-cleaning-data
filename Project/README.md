CGetting and Cleaning Data from 
================================

The purpose of this project
----------------------------
> The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Background 
--------------------------------------
The original Human Activity Recognition database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data Set Information:
--------------------------------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

My Assignment
--------------------------------------
 I should create one R script called run_analysis.R that does the following. 

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names. 

> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

There are 4 files in this repository
--------------------------------------
- *run_analysis.R* : the R script that does the assignment on the data set
- *CodeBook.md* : the CodeBook reference for the run_analysis.r
- *Tidy.txt* : The tidy data I created at the end of the assignment
- *README.md* : and the Read Me file which you are reading now
