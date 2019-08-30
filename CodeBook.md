Download the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Dataset extracted in folder called UCI HAR Dataset

Assign each data to variables
features <- features.txt
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
activity_labels <- activity_labels.txt 
List of activities subjects were performing during measurements
subject_test <- test/subject_test.txt
subject id in test dataset
X_test <- test/X_test.txt
recorded features test data
y_test <- test/y_test.txt
test activity labels
subject_train <- test/subject_train.txt 
subject id in train dataset
X_train <- test/X_train.txt
recorded features train data
y_train <- test/y_train.txt 
train activity labels

Merging  datasets
X (10299 rows, 561 columns) created by merging X_train and X_test with rbind() function
y (10299 rows, 1 column) created by merging y_train and y_test with rbind() function
subjects (10299 rows, 1 column) created by merging subject_train and subject_test with rbind() function
final (10299 rows, 563 column) created by merging subjects, y and X with cbind() function

Renaming 1st column of final dataset tu "subject", and 2nd column to "activity"
Keeping only unique column names in final data set with unique() function
Loaded dplyr library
Extracts only the measurements on the mean and standard deviation for each measurement
final_mstd (10299 rows, 88 columns) created by subsetting final dataset columns subject, activity and columns that cointains mean and std in their names

Using descriptive activity names to name the activities in the data set
Numbers in activity column replaced with activity taken from second column of the activity_labels variable

Appropriately labels the data set with descriptive variable names
Acc in column’s name replaced by Accelerometer
Gyro in column’s name replaced by Gyroscope
BodyBody in column’s name replaced by Body
Mag in column’s name replaced by Magnitude
character f in column’s name replaced by Frequency
character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
indds (180 rows, 88 columns) created by sumarizing final_mstd taking the means of each variable for each activity
dataset exported to indds.txt