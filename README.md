# Getting and Cleaning Data Course Project

This script provides the functionality required for the project of the coursera course "Getting and Cleaning Data" ( https://class.coursera.org/getdata-011 ). 

The script assumes the original data to be located and extracted in its working directory. When sourced, it will load the data sets of both - the training as well as the testing data sets, and extracts the features containing means or standard deviations of the different sensor data. The column/feature names are made human readable and are freed from special characters. The script also enriches the dataset entries with their according activities as well as the subjects which have executed the experiments.

The resulting data set will be stored in a variable "allData".

As a second outcome, an additional data set is created which contains the average values of the above mentioned features grouped by subject and activity. The resulting set is then written to a file called "result.txt".