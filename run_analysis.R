#set working directory
setwd("C:/Users/MEder/Dropbox/PhD/R/Getting and cleaning data")

#load library
library(dplyr)

#load data sets
test <- read.table("UCI HAR Dataset/test/X_test.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#assign colnames
features <- make.names(names=features[[2]], unique=TRUE, allow_ = TRUE)
colnames(test) <- features
colnames(train) <- features

#combine data sets
test <- cbind(test, activity_ID = ytest[[1]])
train <- cbind (train, activity_ID = ytrain[[1]])
complete <- rbind(test, train)
complete <- tbl_df(complete)

#select values
slct <- select(complete, activity_ID, contains("mean"), contains("std"))

#assign activity 
slct$activity_ID <- sapply(slct$activity_ID,switch,'1'='WALKING','2'='WALKING_UPSTAIRS','3'='WALKING_DOWNSTAIRS', '4'='SITTING','5'='STANDING','6'='LAYING')

#tidy and print data set
slct %>% group_by(activity_ID) %>% summarise_each(funs(mean)) %>% write.table("run_analysis.txt", row.name=FALSE)

