## Set working directory to the directory where this script resides
setwd("~/Coursera/Getting_and_Cleaning_Data/getdata-011-proj/")
## IF you have the UCI HAR Dataset contents unzipped and residing in 
## "./UCI HAR Dataset", then comment out the following 2 lines of code to avoid 
## downloading and unzipping the data again.
## Start 2 lines of code to download and unzip
source("download.R")
download()
## End 2 lines of code to download and unzip

## Read training and testing data and labels into data frames (or tables)
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt",
                      col.names="activityid")
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt",
                     col.names="activityid")
## Read the subject data into data frames
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            col.names=c("subjectid"))
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                            col.names=c("subjectid"))
## rbind them to merge train and test sets
x.all <- rbind(x.train, x.test)
y.all <- rbind(y.train, y.test)
subject.all <- rbind(subject.train, subject.test)
## remove separated data to save memory
rm(x.train, y.train, x.test, y.test, subject.train, subject.test)
## Read feature vector labels/column names for x
x.labels <- read.table("./UCI HAR Dataset/features.txt") 
## remove 
colnames(x.all) <- x.labels[,2]
rm(x.labels)
## keep only measurements for mean and std dev. (columns with mean() and std()
## in their names)
x.all <- x.all[,(grepl("mean()", colnames(x.all),
                        fixed=TRUE) | grepl("std()", colnames(x.all)
                                            , fixed=TRUE))]
# cbind x, y, & subject data to form master dataset
master.all <- cbind(x.all, y.all, subject.all)
rm(x.all, y.all, subject.all)

## Read labels for y
y.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(y.labels) <- c("activityid", "activityname")
master.all <- merge(master.all, y.labels, by.x="activityid", by.y="activityid")
rm(y.labels)
## remove the act_id column since we do not need it anymore
master.all <- master.all[,(2:ncol(master.all))]
## convert subject_id to a factor
master.all$subjectid <- as.factor(master.all$subjectid)
## remove brackets (unecessary), and set to all lower case as per week 4 slides
colnames(master.all)<-tolower(colnames(master.all))
colnames(master.all) <- gsub("\\(\\)", "", colnames(master.all))

## Create  a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
library(plyr)
ave.vars <- ddply(master.all, .(activityname, subjectid), numcolwise(mean))
## Change the column names to reflect they are averages by prefixing each of the
## columns with "average" except for the subject id and the activity description
## columns
ave.colnames <- colnames(ave.vars)
f1 <- function(x,y) paste(y,x, sep="-")
ave.colnames <- sapply(ave.colnames, f1, "average")
ave.colnames[1] <- "activityname"
ave.colnames[2] <- "subjectid"
colnames(ave.vars) <- ave.colnames
## write to text file
write.table(ave.vars, file="./averages.txt", row.names=FALSE)

## To extract column names for the Codebook (you will still have to use a text
## editor to remove the quotation marks):
columns.codebook <- rbind(c(1:68), names(ave.vars))
columns.codebook <- t(columns.codebook)
write.table(columns.codebook, file="./colnames.txt", row.names=FALSE, col.names=FALSE, sep=". ")

