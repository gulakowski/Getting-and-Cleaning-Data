run_analysis <- function(){

    
if(!file.exists("Class Project")){
    dir.create("Class Project")
    setwd("Class Project")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "project.zip")
    unzip("project.zip")
    setwd("UCI HAR Dataset")
} else {
    setwd("Class Project")
    setwd("UCI HAR Dataset")
} ## End if/else
    
## load needed libraries    
    library(data.table)
    library(plyr)
    library(dplyr)

## common variables to test and train    
    activity_labels <- read.table("activity_labels.txt")
    features <- read.table("features.txt")
    
## extrtact test data and add names
    x_test <- read.table("./test/X_test.txt")
        colnames(x_test) <- features[,2]
## read activity labels     
    y_test <- read.table("./test/y_test.txt")
        colnames(y_test) <- "Activity"
        y_test$Activity <-  mapvalues(y_test$Activity, from = c(1:6), to = as.character(activity_labels[,2]))
## Read Subject Names    
    subject_test <- read.table("./test/subject_test.txt")
## create test data set    
    testmerge <- cbind(subject_test,y_test, x_test)
## remove unneeded variables   
        rm(subject_test)
        rm(y_test)
        rm(x_test)
## extract traind data    
    x_train <- read.table("./train/X_train.txt")
        colnames(x_train) <- features[,2]
## extract activity labels    
    y_train<- read.table("./train/y_train.txt")
        colnames(y_train) <- "Activity"
        y_train$Activity <-  mapvalues(y_train$Activity, from = c(1:6), to = as.character(activity_labels[,2]))
## read subject names    
    subject_train <- read.table("./train/subject_train.txt")
    subject_train[1,] <- 1 ## error in data value used to correct
## Create train data set
    trainmerge <- cbind(subject_train,y_train, x_train)
## remove unneeded variables     
        rm(subject_train)
        rm(x_train)
        rm(y_train)
## Merge test and training set    
    datamerge <- rbind(testmerge, trainmerge)
## Extract Measuuremnts on the mean and STD Dev
    a<-grepl("mean",names(datamerge),ignore.case = TRUE)
    b<-grepl("std",names(datamerge),ignore.case = TRUE)
    c<- a|b
## rebuild build data frame with only mean and std    
    extData <-cbind("Subject" = datamerge[,1], "Activity" = datamerge[,2], datamerge[,c])
    
##Create Second Data Set w/ average of each variable for each activity and subject
    dataList <- list(NULL) 
    
    for (i in 3:88) {
        dataList[[i-2]]<- tapply(extData[,i],list(extData[,2],extData[,1L]),mean)
    } ## End for Loop
        
    
## Assign meaning full names to data sets    
    names(dataList)<-names(extData)[3:88]
    
## Returns output as list
## extData as Data Frame (part 1)
## dataList as list
    
    output <- list(DataSet1 = extData, DataSet2 = dataList)
    write.table(as.data.frame(output), file = "Gulakowski Project.txt")
    output
    
} ## end run_analysis