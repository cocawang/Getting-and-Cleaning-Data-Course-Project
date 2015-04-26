x_train <- read.table("data/X_train.txt")
x_test <- read.table("data/X_test.txt")
y_train <- read.table("data/y_train.txt")
y_test <- read.table("data/y_test.txt")
subject_train <- read.table("data/subject_train.txt")
subject_test <- read.table("data/subject_test.txt")
train <- data.frame(x_train,y_train,subject_train)
test <- data.frame(x_test,y_test,subject_test)
entire_data <- rbind(train, test)    ##merge datasets

feature <- read.table("data/features.txt")
feature1 <- feature[grep("std()", feature$V2), ]
feature2 <- feature[grep("mean()", feature$V2,fixed=TRUE), ]
feature <- rbind(feature1,feature2)
feature <- feature[order(feature$V1),]

measures <-entire_data[,c(feature$V1,562,563)] ## Extract Mean and STD variables

## name activity
measures$V1.1[measures$V1.1 == "1"] <- "walking"
measures$V1.1[measures$V1.1 == "2"] <- "walking_upstairs"
measures$V1.1[measures$V1.1 == "3"] <- "walking_downstairs"
measures$V1.1[measures$V1.1 == "4"] <- "sitting"
measures$V1.1[measures$V1.1 == "5"] <- "standing"
measures$V1.1[measures$V1.1 == "6"] <- "laying"

names(measures)[1:66] <- as.character(feature$V2)
names(measures)[67] <- "activity"
names(measures)[68] <- "subject"

measures$subject <- as.character(measures$subject)
measures1 <- measures[,1:66]
cleandata <- aggregate(measures1, by=list(measures$activity,measures$subject), mean)

write.table(cleandata, file="clean_data.txt",row.names=FALSE)
