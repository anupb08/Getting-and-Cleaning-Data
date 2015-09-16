##Getting and Cleaning Data - Course Project

This repository hosts the R code and documentation files for the "Getting and Cleaning Data" course in coursera

###Files
1. run_analysis.R
2. CodeBook.md
3. tidydata.txt

#### Before execute run_analysis.R, please do: 
  Download the dataset "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    and extract zip file. It will create a directory "UCI HAR Dataset". (If no such directory was create, then create same and copy all the files inside this directory)

1.  Set current directory to "UCI HAR Dataset"   
2.  Load the train and test dataset
3.  Load the activity and feature info 
4.  Merge training and test datasets, and keeping only those columns which reflect a mean or standard deviation measurements
5.  Loads the activity and subject data, and merges those columns with the avobe dataset
6.  Appropriately labels the data set with descriptive variable names. 
7.  Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

