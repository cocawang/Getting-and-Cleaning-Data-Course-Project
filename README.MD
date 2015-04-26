# How the script works:
run_analysis.R code basically finish the clean process according to the project requirement 

# Input: 
txt data sets under data folder(X_test.txt, X_train.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt,features.txt, activity_labels.txt)
# Process:
run run_analysis.R code
#Output: 
independent tidy data set with the average of each variable for each activity and each subject.

# The process code following the project instruction as below:
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Code & descriptions:
Merges the training and the test sets to create one data set.

* x_train <- read.table("data/X_train.txt") # read X_train.txt from project data folder
* x_test <- read.table("data/X_test.txt") # read X_test.txt from project data folder
* y_train <- read.table("data/y_train.txt") # read y_train.txt from project data folder
* y_test <- read.table("data/y_test.txt") # read y_test.txt from project data folder
* subject_train <- read.table("data/subject_train.txt") # read subject_train.txt from project data folder
* subject_test <- read.table("data/subject_test.txt") # read subject_test.txt from project data folder
* train <- data.frame(x_train,y_train,subject_train) # merge train data set 
* test <- data.frame(x_test,y_test,subject_test) # merge test data set
* entire_data <- rbind(train, test)    ## merge datasets to entire_data set

Extracts only the measurements on the mean and standard deviation for each measurement.
* feature <- read.table("data/features.txt") # read features.txt from project data folder
* feature1 <- feature[grep("std()", feature$V2), ] # select standard deviation features in feature table 
* feature2 <- feature[grep("mean()", feature$V2,fixed=TRUE), ]# select mean features in feature table 
* feature <- rbind(feature1,feature2) # create feature table only has mean & std features
* feature <- feature[order(feature$V1),] # sort feature table
* measures <-entire_data[,c(feature$V1,562,563)] # Extract Mean and STD variables on entire_data set


Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
* measures$V1.1[measures$V1.1 == "1"] <- "walking" # label activities
* measures$V1.1[measures$V1.1 == "2"] <- "walking_upstairs"
* measures$V1.1[measures$V1.1 == "3"] <- "walking_downstairs"
* measures$V1.1[measures$V1.1 == "4"] <- "sitting"
* measures$V1.1[measures$V1.1 == "5"] <- "standing"
* measures$V1.1[measures$V1.1 == "6"] <- "laying"
* names(measures)[1:66] <- as.character(feature$V2) # label vairables name with feature table
* names(measures)[67] <- "activity" # label activity variable
* names(measures)[68] <- "subject" # label subject variable

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* measures$subject <- as.character(measures$subject) #character subject vairable
* measures1 <- measures[,1:66] # subset data
* cleandata <- aggregate(measures1, by=list(measures$activity,measures$subject), mean) # aggregate data and get mean by group activity & subject

Save cleandata
* write.table(cleandata, file="clean_data.txt",row.names=FALSE)

