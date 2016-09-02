##reads activity_labels and features files
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
##reads files from test
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
##reads files from train
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")


##1. Merges the training and the test sets to create one data set.

##Names xtest and xtrain columns with features
names(xtest) = features$V2
names(xtrain) = features$V2

##Joins ytest to an activity
ytest <- merge(ytest, activitylabels)
ytrain <- merge(ytrain, activitylabels)

##Sets the name of the columns with the activity_labels
names(ytest) <- c("activityid", "activityname")
names(ytrain) <- c("activityid", "activityname")

#binds test information
test <- cbind(testsubject, xtest, ytest)
##binds train information
train <- cbind(trainsubject, xtrain, ytrain)
##binds test with train
data <- rbind(test, train)



##2. Extracts only the measurements on the mean and standard deviation for each measurement.

##Extracts Mean
extracts <- data[grep("[Mm][e][a][n]|[s][t][d]", names(data), value = TRUE)]


##STEP 3 AND 4 WERE USED IN STEP 1

##3. Uses descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.



##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

avg <- aggregate(.~data$activityname, data, mean)
