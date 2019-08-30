url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "Dataset.zip")
unzip("dataset.zip")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(X_test)<-features$V2
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(X_train)<-features$V2
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subjects <- rbind(subject_train, subject_test)
final <- cbind(subjects, y, X)
names(final)[1]<-"subject"
names(final)[2]<-"activity"
final<-final[, unique(colnames(final))]
library(dplyr)
final_mstd<-select(final, subject, activity, contains("mean"), contains("std"))
final_mstd$activity <- activity_labels[final_mstd$activity, 2]
names(final_mstd)<-gsub("Acc", "Accelerometer", names(final_mstd))
names(final_mstd)<-gsub("Gyro", "Gyroscope", names(final_mstd))
names(final_mstd)<-gsub("BodyBody", "Body", names(final_mstd))
names(final_mstd)<-gsub("Mag", "Magnitude", names(final_mstd))
names(final_mstd)<-gsub("^t", "Time", names(final_mstd))
names(final_mstd)<-gsub("^f", "Frequency", names(final_mstd))
names(final_mstd)<-gsub("tBody", "TimeBody", names(final_mstd))
names(final_mstd)<-gsub("-mean()", "Mean", names(final_mstd), ignore.case = TRUE)
names(final_mstd)<-gsub("-std()", "STD", names(final_mstd), ignore.case = TRUE)
names(final_mstd)<-gsub("-freq()", "Frequency", names(final_mstd), ignore.case = TRUE)
names(final_mstd)<-gsub("angle", "Angle", names(final_mstd))
names(final_mstd)<-gsub("gravity", "Gravity", names(final_mstd))
indds <- final_mstd %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(indds, "indds.txt", row.name=FALSE)

