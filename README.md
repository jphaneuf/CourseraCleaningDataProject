---
title: "Readme"
author: "Joe Phaneuf"
date: "11/22/2014"
output: html_document
---

Hello, friend.  Welcome!  

By now you've found the R script "run_analysis.R"  
This script is intended to merge, clean and reshape accelerometer and gyroscope data collected from a   smartphone during various activities.  

The full Dataset can be found here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The script should be saved to the same folder as the extracted data set, for example:  
../gettingandcleaningdata/UCI HAR Dataset  
../gettingandcleaningdata/run_analysis.R  

The script will perform the following:  
1) For both the Test and Training Datasets, the sensor data will be matched to participant and activity data, after which the Test and Training Datasets will be merged.  
2) Means and standard deviations have been calculated for all of the signals already.  These will be   extracted, leaving behind other computed functions  
3) The activities at which each measurement was taken will be mapped from a number to a descriptive factor (i.e 1 becomes "walking")  
4) Signal names will be formatted and cleaned, removing non alpha-numeric characters, odd strings, and enforcing consisten capitilization  
5) The dataset will be melted into four columns (subject, activity, signal, value), and then collapsed by the mean of the values for each group of subject/activity/signal.  This tidy data set will be exported as:
**SamsungGalaxySII_activity.txt**  

Please see the codebook for this project for explanations of variables

