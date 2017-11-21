setwd("C:/Users/charless/Dropbox/Courses/Data Science Certificate/03) Getting and Cleaning Data/Week 4")
rm(list = ls())

library(dplyr)

#Gets Data from
filename <- "getdat_Fprojectfiles_FUCI_HAR_Dataset.zip"
if(!file.exists(filename)){
  Location1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(Location1, filename, mode = "wb", cacheOK = FALSE)
    rm(Location1)
}
if(!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}
rm(filename)

Features <- read.table("UCI HAR Dataset/features.txt")

#Import Training & Test Datasets
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
TrainLabels <- read.table("UCI HAR Dataset/train/Y_train.txt")
TrainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
TestLabels <- read.table("UCI HAR Dataset/test/Y_test.txt")
TestSet <- read.table("UCI HAR Dataset/test/X_test.txt")

#Sets the Column Names
colnames(TrainSubjects) <- "Subject"
colnames(TestSubjects) <- "Subject"
colnames(TrainLabels) <- "Label"
colnames(TestLabels) <- "Label"
colnames(TrainSet) <- Features[, 2]
colnames(TestSet) <- Features[, 2]
rm(Features)

#Merges Datasets
Train <- cbind(TrainSubjects, TrainLabels, TrainSet)
Test <- cbind(TestSubjects, TestLabels, TestSet)
DataSet <- rbind(Train, Test)
rm(TrainSubjects, TrainLabels, TrainSet, Train, TestSet, TestLabels, TestSubjects, Test)

#Extracts MEAN and STD Columns
Columns <- grepl("mean", colnames(DataSet)) & !grepl("meanFreq", colnames(DataSet)) | grepl("std", colnames(DataSet)) & !grepl("stdFreq", colnames(DataSet))
Columns[1:2] <- TRUE
DataSet <- DataSet[,Columns]
rm(Columns)

#Adds Activity Definition Column
Activity <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(Activity) <- c("Label","Activity")
DataSet <- merge(Activity, DataSet, by.x = "Label")
rm(Activity)

#Calculates the Average of Each Variable for Each Activity and Each Subject
DataSet$Subject <- as.factor(DataSet$Subject)
DataSet$Activity <- as.factor(DataSet$Activity)
Columns <- grepl("mean", colnames(DataSet))
Columns[2:3] <- TRUE
DataSet <- DataSet[,Columns]
rm(Columns)
Average <- DataSet %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))