#Load list of features and activity descriptors
script.dir <- dirname(sys.frame(1)$ofile)
print(paste(script.dir,"/UCI HAR Dataset",sep=""))
setwd(paste(script.dir,"/UCI HAR Dataset",sep=""))
featureList <- read.table("features.txt")
activityList <- read.table("activity_labels.txt")
#Load datasets
testData <- read.table("./test/X_test.txt")
testSubjects <- read.table("./test/subject_test.txt")
testActivity <- read.table("./test/y_test.txt")
trainData <- read.table("./train/X_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")
trainActivity <- read.table("./train/y_train.txt")

#TASK 1
#combine training and test data sets
testSet <- cbind(testSubjects,testActivity,testData)
trainSet <- cbind(trainSubjects,trainActivity,trainData) # haha, playing with my train set
fullSet <-rbind(testSet,trainSet)
colnames(fullSet) <- c("subject","activity",as.character(featureList[,2]))

#TASK 2
#Pick out only columns that are mean() or std() of measurements
whereMean <- sapply(names(fullSet),function(atext) grepl("mean\\(\\)",atext))
whereStd <- sapply(names(fullSet),function(atext) grepl("std\\(\\)",atext))
keep <- whereMean|whereStd
keep[1:2] <- TRUE #subject and activity
fullSet<-fullSet[,keep]

#TASK 3
#Descriptive Names for Activities in Dataset
#Map Number to name from activity list
getActivity <- function(anumber) activityList[grep(anumber,activityList[,1]),2]
fullSet[,2] <- sapply(fullSet[,2],getActivity)

#TASK 4
#Clean up names
colnames(fullSet) <- sapply(colnames(fullSet), function(astring) gsub("BodyBody","Body",astring)) #what is a bodybody?
colnames(fullSet) <- sapply(colnames(fullSet), function(astring) gsub("[()-.,]","",astring)) #remove non-alphanumeric
colnames(fullSet) <- sapply(colnames(fullSet), function(astring) gsub("mean","Mean",astring)) #capitalize Mean
colnames(fullSet) <- sapply(colnames(fullSet), function(astring) gsub("std","Std",astring)) #capitalize Std

#TASK 5
#Tidy Data, Narrow
library(reshape)
meltSet<- melt(fullSet,id=c("subject","activity"))
tidySet <- aggregate(meltSet$value,list(subject=meltSet$subject,activity=meltSet$activity,signal=meltSet$variable),mean)
colnames(tidySet)[4] <- "value"

#Ship it
write.table(tidySet,paste(script.dir,"/SamsungGalaxySII_activity.txt",sep=""),row.name=FALSE)