This Script is for the Getting and Cleaning Data Peer-graded Assignment. The R script, `run_analysis.R`, does the following:

1. Get data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip files
2. Imports Training & Test Datasets
3. Sets the Column Names
4. Merges Datasets
5. Extracts MEAN and STD Columns
6. Adds Activity Definition Column
7. Calculates the Average of Each Variable for Each Activity and Each Subject